# frozen_string_literal: true
require Sufia::Engine.root.join('app/jobs/attach_files_to_work_job.rb')
class AttachFilesToWorkJob < ActiveJob::Base
  def perform(work, uploaded_files)
    uploaded_files.each do |uploaded_file|
      file_set = FileSet.new
      user = User.find_by_user_key(work.depositor)
      actor = CurationConcerns::Actors::FileSetActor.new(file_set, user)
      actor.create_metadata(work, visibility: work.visibility) do |file|
        file.permissions_attributes = work.permissions.map(&:to_hash)
      end

      attach_content(actor, uploaded_file.file)
      uploaded_file.update(file_set_uri: file_set.uri)
    end
    work.save! # Temp fix to https://github.com/uclibs/scholar_uc/issues/1023
  end
end
