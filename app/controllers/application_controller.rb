class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  include CurateController
  helper Openseadragon::OpenseadragonHelper

  # Please be sure to impelement current_user and user_session. Blacklight depends on
  # these methods in order to perform user specific actions.

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception do |exception|
      @exception = exception
      log_exception
      notify_exception
      render_404
    end
  end

  protected

  def exception_message
    message = @exception.to_s.gsub("\n", " ")
    user = current_user.present? ? current_user.email : 'unauthenticated'
    parameters = params.present? ? params.to_s.gsub("\n", " ") : ''
    current_path = request.fullpath
    "Rescued exception: #{ message } -- path: #{ current_path } -- params: #{ parameters } -- user: #{ user }"
  end

  def log_exception
    logger.error(exception_message)
  end

  def notify_exception
    return unless production_server?
    @formatted_message = exception_message.gsub('--', "\n\n")
    if !(trivial_exception? && unauthenticated_user?)
      subject = "#{t('sufia.product_name')}: Exception Alert"
      NotificationMailer.notify('', '', subject, @formatted_message).deliver
    end
  end

  def production_server?
    return true if Curate.configuration.application_root_url == "https://scholar.uc.edu/"
  end

  def trivial_exception?
    ['in fedora',
     'not found in solr',
     '401 unauthorized'].any? { |word| @formatted_message.include?(word) }
  end

  def unauthenticated_user?
      @formatted_message.include? "user: unauthenticated"
  end

  def render_404
    render(:file => 'public/404.html', :layout => false, :status => 404)
  end


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def after_sign_out_path_for(resource_or_scope)
    if cookies[:login_type] == "shibboleth"
      "/Shibboleth.sso/Logout?return=https%3A%2F%2Fbamboo_shibboleth_logout"
    else
      root_path
    end
  end
end
