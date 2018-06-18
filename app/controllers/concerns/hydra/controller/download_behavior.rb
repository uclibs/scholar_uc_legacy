# frozen_string_literal: true
require HydraHead::Engine.root.join('app/controllers/concerns/hydra/controller/download_behavior.rb')
module Hydra
  module Controller
    module DownloadBehavior
      extend ActiveSupport::Concern

      protected

        def content_options
          { disposition: disposition, type: file.mime_type, filename: file_name }
        end

        def disposition
          if file.mime_type == 'application/pdf'
            'attachment'
          else
            'inline'
          end
        end
    end
  end
end
