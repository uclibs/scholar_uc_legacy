# frozen_string_literal: true
class ShibbolethLogoutController < ActionController::Base
  def show
    render text: "You have been logged out of the University of Cincinnati's Login Service"
  end
end

test_routes = proc do
  get '/Shibboleth.sso/Logout' => 'shibboleth_logout#show'
end

Rails.application.routes.send :eval_block, test_routes
