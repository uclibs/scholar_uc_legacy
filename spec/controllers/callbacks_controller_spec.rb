require 'spec_helper'

describe CallbacksController do
  let(:provider) { :shibboleth }
  let(:uid) { 'sixplus2@test.com' }
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    OmniAuth.config.add_mock(provider, {uid: uid, credentials: {}})
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
  end

  context 'with a registered user' do
    let(:user) { FactoryGirl.create(:shibboleth_user) }
    before(:each) do
      User.should_receive(:find_by_provider_and_uid).with(provider.to_s, uid).and_return(user)
    end
    it 'should assign the user and redirect' do
      get provider
      expect(flash[:notice]).to match(/You are now signed in as */)
      expect(assigns(:user)).to eq(user)
      expect(response).to be_redirect
    end
  end

  context 'with a user who is already logged in' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      controller.stub(:current_user).and_return(user)
    end
    it 'redirects to catalog index path' do
      get :shibboleth
      response.should redirect_to(catalog_index_path)
    end
  end

end

