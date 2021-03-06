# frozen_string_literal: true
module ManifestPresenter
  extend ActiveSupport::Concern

  def manifest_url
    manifest_helper.polymorphic_url([:manifest, self])
  end

  private

    def manifest_helper
      @manifest_helper ||= ManifestHelper.new
    end
end
