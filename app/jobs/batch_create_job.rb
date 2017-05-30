# frozen_string_literal: true
class BatchCreateJob < ActiveJob::Base
  queue_as Hyrax.config.ingest_queue_name

  before_enqueue do |job|
    operation = job.arguments.last
    operation.pending_job(self)
  end

  # This copies metadata from the passed in attribute to all of the works that
  # are members of the given upload set
  # @param [User] user
  # @param [Hash<String => String>] titles
  # @param [Hash<String => String>] resource_types
  # @param [Array<String>] uploaded_files Hyrax::UploadedFile IDs
  # @param [Hash] attributes attributes to apply to all works, including :model
  # @param [BatchCreateOperation] log
  def perform(user, titles, uploaded_files, attributes, log)
    operation.performing!
    titles ||= {}
    create(user, titles, uploaded_files, attributes, log)
  end

  private

    def create(user, titles, uploaded_files, attributes, operation)
      model = attributes.delete(:model) || attributes.delete('model')
      raise ArgumentError, 'attributes must include "model" => ClassName.to_s' unless model
      uploaded_files.each do |upload_id|
        title = [titles[upload_id]] if titles[upload_id]
        attributes = attributes.merge(uploaded_files: [upload_id],
                                      title: title)
        child_operation = Hyrax::Operation.create!(user: user,
                                                   operation_type: "Create Work",
                                                   parent: operation)
        CreateWorkJob.perform_later(user, model, attributes, child_operation)
      end
    end
end
