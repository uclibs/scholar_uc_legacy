require 'spec_helper'

describe ContactRequestsController do
  describe 'GET #new' do
    let(:user) { FactoryGirl.create(:user) }
    it 'is allowed when not logged in' do
      get(:new)
      expect(response.status).to eq(200)
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do

    it 'successfully allows reCaptcha' do
      ContactRequestsController.any_instance.stub(:verify_google_recaptcha).and_return(true)
      NotificationMailer.any_instance.stub(:notify).and_return(true)
      post(:create)
      response.should redirect_to(catalog_index_path)
    end

    it 'fails on reCaptcha failure' do
      ContactRequestsController.stub(:verify_google_recaptcha).and_return(false)
      post(:create) 
      response.should render_template("contact_requests/new")
    end
  end
end
