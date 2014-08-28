require 'spec_helper'

describe 'user login sessions' do
  it 'routes to catalog#index on successfull login' do
    expect(:get => "/user_root").to route_to(
      :controller => "catalog", 
      :action => "index"
    )
  end

end


