# frozen_string_literal: true
module Sufia
  class ManifestEnabledWorkShowPresenter < Sufia::WorkShowPresenter
    self.file_presenter_class = Sufia::FileSetPresenter

    def manifest_url
      manifest_modifier
      manifest_helper.polymorphic_url([:manifest, self])
    end

    private

      def manifest_helper
        @manifest_helper ||= ManifestHelper.new
      end

      def manifest_modifier
        @file_set_ids.each do |id|
          mime_type_file = FileSet.find(id).mime_type
          unless mime_type_file == 'image/jp2' || mime_type_file == 'image/tiff' || mime_type_file == 'image/png' || mime_type_file == 'image/jpeg'
            @file_set_ids -= [id]
          end
        end
      end
  end
end
