# frozen_string_literal: true
module Sufia
  class ManifestEnabledWorkShowPresenter < Sufia::WorkShowPresenter
    self.file_presenter_class = Sufia::FileSetPresenter

    def manifest_url
      manifest_helper.polymorphic_url([:manifest, self])
    end

    private

      def manifest_helper
        @manifest_helper ||= ManifestHelper.new
      end
  end
end
