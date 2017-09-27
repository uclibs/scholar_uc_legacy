class WorksReport < Report

  private

  def self.report_objects
    works = Array.new
    work_type_classes.each do |type_class|
      type_class.all.each { |work| works << work }
    end
    works
  end

  def self.fields(work = GenericWork.new) 
    [
      { pid: work.id },
      { owner: work.owner },
      { depositor: work.depositor },
      { editors: work.edit_users.join(" ") },
    ] << attributes(work)
  end

  def self.attributes(work)
    all_attributes_list.map do |attribute|
      if work.class.method_defined? attribute
        { attribute => work.send(attribute) }
      else
        { attribute => nil }
      end
    end
  end

  def self.all_attributes_list
    %i[
      abstract
      advisor
      alternate_title
      bibliographic_citation
      college
      contributor
      committee_member
      coverage_spatial
      coverage_temporal
      degree
      department
      date_created
      creator
      cultural_context
      description
      genre
      identifier
      inscription
      issn
      journal_title
      language
      location
      material
      measurement
      note
      publisher
      requires
      source
      subject
      title
      type
      visibility
    ]
  end

  def self.work_type_classes
    Hyrax.config.registered_curation_concern_types.collect { |type| type.constantize }
  end
end

