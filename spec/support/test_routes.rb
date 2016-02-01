class ShibbolethLogoutController < ActionController::Base
  def show
    render text: "You have been logged out of the University of Cincinnati's Login Service"
  end
end

test_routes = Proc.new do
  get '/Shibboleth.sso/Logout' => 'shibboleth_logout#show'
end

Rails.application.routes.eval_block(test_routes)
