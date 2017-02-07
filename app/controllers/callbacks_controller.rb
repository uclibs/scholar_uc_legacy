# frozen_string_literal: true
class CallbacksController < Devise::OmniauthCallbacksController
  def orcid
    omni = request.env["omniauth.auth"]
    Devise::MultiAuth.capture_successful_external_authentication(current_user, omni)
    redirect_to root_path, notice: "You have successfully connected with your ORCID record"
  end
end
