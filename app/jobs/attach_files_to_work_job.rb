# frozen_string_literal: true
require Hyrax::Engine.root.join('app/jobs/attach_files_to_work_job.rb')
class AttachFilesToWorkJob < ActiveJob::Base
  def perform(work, uploaded_files)
    uploaded_files.each do |uploaded_file|
      file_set = FileSet.new
      user = User.find_by_user_key(work.depositor)
      actor = Hyrax::Actors::FileSetActor.new(file_set, user)
      actor.create_metadata(visibility: work.visibility)
      attach_content(actor, uploaded_file.file)
      actor.attach_file_to_work(work)
      actor.file_set.permissions_attributes = work.permissions.map(&:to_hash)
      uploaded_file.update(file_set_uri: file_set.uri)
    end
    work.save! # Temp fix to https://github.com/uclibs/scholar_uc/issues/1023
  end
end
