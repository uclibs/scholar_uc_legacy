# frozen_string_literal: true
require Hyrax::Engine.root.join('app/actors/hyrax/actors/file_actor.rb')
module Hyrax
  module Actors
    class FileActor
      def ingest_file(file, asynchronous)
        method = if asynchronous
                   :perform_later
                 else
                   :perform_now
                 end

        # OVERRIDE: Add file_set_filename parameter to ingest_options
        IngestFileJob.send(method,
                           file_set,
                           working_file(file),
                           user,
                           ingest_options(file, file_set_filename))
        true
      end

      private

        # OVERRIDE: Add filename parameter; Change how opts[:filename] is assigned
        def ingest_options(file, filename, opts = {})
          opts[:mime_type] = file.content_type if file.respond_to?(:content_type)
          opts[:filename] = file.respond_to?(:original_filename) ? file.original_filename : filename
          opts.merge!(relation: relation)
        end

        def file_set_filename
          if file_set.import_url.present?
            # This is a cloud resource
            resourcename = HTTParty.get(file_set.import_url).header['content-disposition']
            resourcename.split('"')[1]
          else
            # This is not a cloud resource
            file_set.label
          end
        end
    end
  end
end
