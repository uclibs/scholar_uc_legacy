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

  before_action :store_current_location

  private

    def auth_shib_user!
      redirect_to login_path unless user_signed_in?
    end

    # override devise helper and route to CC.new when parameter is set
    def after_sign_in_path_for(_resource)
      cookies[:login_type] = "local"
      return root_path unless parameter_set?
      route_to_correct_path
    end

    def after_sign_out_path_for(_resource_or_scope)
      if cookies[:login_type] == "shibboleth"
        "/Shibboleth.sso/Logout?return=https%3A%2F%2Fbamboo_shibboleth_logout"
      else
        root_path
      end
    end

    # these are empty by default. implement these methods to change routing functionality after sign up
    # per controller. see hyrax/homepages_controller.rb in the app for an example

    def route_to_correct_path
      new_classify_concern_path
    end

    def store_current_location; end

    def parameter_set?
      session['user_return_to'] == '/'
    end
end
