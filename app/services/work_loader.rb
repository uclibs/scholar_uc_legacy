# frozen_string_literal: true
class WorkLoader
  NON_REPEATABLE_ATTRIBUTES = %i{
    rights visibility_during_embargo embargo_relase_date
    visibility_after_embargo visibility alt_date_created
    existing_identifier college department
  }.freeze

  REPEATABLE_ATTRIBUTES = %i{
    title creator publisher
    subject language related_url
    member_of_collection_ids alternate_title
    journal_title issn time_period geo_subject
  }.freeze

  TEXT_ATTRIBUTES = %i{
    required_software note alt_description
  }.freeze

  attr_accessor :curation_concern, :file_attributes, :user, :actor, :ability, :attributes_hash

  def initialize(attributes_hash)
    @user             = User.find_by_email    attributes_hash.delete(:submitter_email)
    @file_attributes  = create_uploaded_files attributes_hash.delete(:files)
    @curation_concern = new_curation_concern  attributes_hash.delete(:work_type)
    @attributes_hash  = attributes_hash
  end

  def create
    work_pid = attributes_hash.delete(:pid)
    curation_concern.id = work_pid unless work_pid.nil?
    actor.create(attributes_for_actor(attributes_hash))

    editor_emails = attributes_hash.delete(:edit_access) || []
    [editor_emails].flatten.each do |email|
      self.curation_concern.edit_users += [email]
    end

    reader_emails = attributes_hash.delete(:read_access) || []
    [reader_emails].flatten.each do |email|
      self.curation_concern.read_users += [email]
    end

    related_works = attributes_hash.delete(:member_work_ids) || []
    [related_works].flatten.each do |id|
      self.curation_concern.members << ActiveFedora::Base.find(id)
    end

    self.curation_concern.save

    file_attributes.each do |file|
      file_set = FileSet.new
      file_pid = file.delete(:pid)
      file_set.id = file_pid unless file_pid.nil?
      visibility = file[:visibility] || curation_concern.visibility

      actor = Hyrax::Actors::FileSetActor.new(file_set, user)
      actor.create_metadata(visibility: visibility)
      actor.create_content(file[:uploaded_file].file.file.to_file)
      actor.attach_file_to_work(curation_concern)
      actor.file_set.permissions_attributes = curation_concern.permissions.map(&:to_hash)

      file.update(file_set_uri: file_set.uri)
      file_set.visibility = visibility
      file_set.save
    end
  end

  def work_log
    [self.curation_concern.id, self.curation_concern.owner]
  end

  def file_log 
    self.curation_concern.file_sets.map do |file_set|
      [file_set.id, self.curation_concern.id]
    end
  end

  def attributes_for_actor(attributes_hash)
    attributes = {}
    attributes_hash.keys.each do |a|
      next unless curation_concern.respond_to? a
      value = attributes_hash[a]

      if NON_REPEATABLE_ATTRIBUTES.include? a
        if value.class == Array
          raise "Repeated value passed for non-repeatable attribute"
        else
          attributes[a] = value
        end
      end

      if REPEATABLE_ATTRIBUTES.include? a
        attributes[a] = if value.class == Array
                          value
                        else
                          [value]
                        end
      end

      next unless TEXT_ATTRIBUTES.include? a
      attributes[a] = if value.class == Array
                        value.join("\n")
                      else
                        value
                      end
    end

    attributes["doi_assignment_strategy"] = if attributes_hash[:doi] == "TRUE" && attributes_hash[:identifier].nil? && attributes_hash[:publisher].present?
                                              "mint_doi"
                                            else
                                              "not_now"
                                            end

    attributes["remote_files"] = []
    attributes["uploaded_files"] = []
    attributes.delete(:member_of_collection_ids) if attributes[:member_of_collection_ids][0].nil?

    attributes
  end

  def ability
    @ability ||= Ability.new(user)
  end

  def create_uploaded_files(file_attributes)
    file_attributes.map do |file|
      file[:uploaded_file] = Hyrax::UploadedFile.create(
        file:    File.open(file[:path]),
        user_id: user.id
      )
      file
    end
  end

  def new_curation_concern(type)
    case type
    when "article" then Article.new
    when "dataset" then Dataset.new
    when "document" then Document.new
    when "etd" then Etd.new
    when "generic_work" then GenericWork.new
    when "image" then Image.new
    when "student_work" then StudentWork.new
    when "media" then Medium.new
    else raise "No valid work type found"
    end
  end

  def actor
    @actor ||= Hyrax::CurationConcern.actor(curation_concern, ability)
  end
end
