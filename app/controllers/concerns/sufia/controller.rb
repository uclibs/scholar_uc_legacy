# frozen_string_literal: true
require Sufia::Engine.root.join('app/controllers/concerns/sufia/controller.rb')
module Sufia::Controller
  # Override Devise method to redirect to dashboard after signing in
  def after_sign_in_path_for(resource)
    if !resource.waived_welcome_page
      Rails.application.routes.url_helpers.welcome_page_index_path
    else
      landing_page
    end
  end

  def landing_page
    Sufia::Engine.routes.url_helpers.dashboard_index_path
  end
end
