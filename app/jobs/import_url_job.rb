# frozen_string_literal: true
require Hyrax::Engine.root.join('app/jobs/import_url_job.rb')

class ImportUrlJob
  protected

    def get_follow_redirects(uri, request_max = 5)
      raise "Max number of redirects reached" if request_max <= 0

      response = Net::HTTP.get_response(uri)
      case response.code.to_i
      when 200
        uri
      when 301..303
        get_follow_redirects(URI(response['location']), request_max - 1)
      else
        raise "Failed to attach cloud file to file_set with uri: #{uri}."
      end
    end

    def copy_remote_file(file_set, f)
      f.binmode
      # download file from url
      uri = URI(file_set.import_url)

      # Uses get_follow_redirects for Browse_everything providers who use redirects.
      loc = get_follow_redirects(uri)

      spec = { 'url' => loc }
      retriever = BrowseEverything::Retriever.new
      retriever.retrieve(spec) do |chunk|
        f.write(chunk)
      end
      f.rewind
    end
end
