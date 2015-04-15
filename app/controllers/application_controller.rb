class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller
   include Blacklight::Controller
  include CurateController

  # Please be sure to impelement current_user and user_session. Blacklight depends on
  # these methods in order to perform user specific actions.

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  protected

  def render_404
    render(:file => 'public/404.html', :layout => false, :status => 404)
  end


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
