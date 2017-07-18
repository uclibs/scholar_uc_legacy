# frozen_string_literal: true
class ApplicationController < ActionController::Base
  helper Openseadragon::OpenseadragonHelper
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  include Hydra::Controller::ControllerBehavior

  # Adds Hyrax behaviors into the application controller
  include Hyrax::Controller

  include Hyrax::ThemedLayoutController
  with_themed_layout '1_column'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :store_current_location, unless: :devise_controller?

  private

    # override devise helper and route to CC.new when parameter is set
    def after_sign_in_path_for(_resource)
      cookies[:login_type] = "local"
      return root_path unless parameter_set?
      route_to_classify_concerns_path
    end

    def after_sign_out_path_for(_resource_or_scope)
      if cookies[:login_type] == "shibboleth"
        "/Shibboleth.sso/Logout?return=https%3A%2F%2Fbamboo_shibboleth_logout"
      else
        root_path
      end
    end

    # store paramater in request
    def store_current_location
      store_location_for(:user, request.url)
    end

    def parameter_set?
      return false if session['user_return_to'].nil?
      session['user_return_to'].include? '/classify_concerns/new'
    end

    def route_to_classify_concerns_path
      session['user_return_to']
    end
end
