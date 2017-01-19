# frozen_string_literal: true
require 'rails_helper'

describe CallbacksController do
  context 'omniauth-orcid' do
    let(:uid) { 'sixplus2@test.com' }
    let(:provider) { :orcid }
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user] # rubocop:disable RSpec/InstanceVariable
      omniauth_hash_orcid = { "provider": "orcid",
                              "uid": "0000-0003-2012-0010",
                              "info": {
                                "name": "John Smith",
                                "email": uid
                              },
                              "credentials": {
                                "token": "e82938fa-a287-42cf-a2ce-f48ef68c9a35",
                                "refresh_token": "f94c58dd-b452-44f4-8863-0bf8486a0071",
                                "expires_at": 1_979_903_874,
                                "expires": true
                              },
                              "extra": {
                              } }
      OmniAuth.config.add_mock(provider, omniauth_hash_orcid)
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
    end

    context 'with a user who is already logged in' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        allow(controller).to receive(:current_user) { user }
      end

      it 'redirects to catalog index path with success notice' do
        get provider
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to match(/You have successfully connected with your ORCID record/)
      end
    end
  end
end
