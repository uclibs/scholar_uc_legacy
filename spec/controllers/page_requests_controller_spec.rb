require 'spec_helper'

describe PageRequestsController do
  describe '#splash_page' do 
    it 'renders a splash page' do
      get :splash_page
      response.status.should == 200
      expect(response).to render_template('page_requests/splash_index')
    end
  end
end
