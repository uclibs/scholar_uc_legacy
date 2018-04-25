# frozen_string_literal: true
require Hyrax::Engine.root.join('app/presenters/hyrax/work_show_presenter.rb')
module Hyrax
  class WorkShowPresenter
    # @return [String] a download URL, if work has representative media, or a blank string
    def download_url
      return '' if representative_presenter.nil?
      Hyrax::Engine.routes.url_helpers.download_url(representative_presenter, host: request.host)
    end

    def members_include_viewable_image?
      member_presenters.any? { |presenter| current_ability.can?(:read, presenter.id) }
    end
  end
end
