require 'spec_helper'

describe CallbacksController do
  let(:provider) { :shibboleth }
  let(:uid) { 'sixplus2@test.com' }
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    omniauth_hash = { provider: 'shibboleth',
                      uid: uid,
                      extra: {
                        raw_info: {
                          mail: uid,
                          title: 'title',
                          telephoneNumber: '123-456-7890',
                          givenName: 'Fake',
                          sn: 'User',
                          uceduPrimaryAffiliation: 'staff',
                          ou: 'department'
                        }
                      }
    }
    OmniAuth.config.add_mock(provider, omniauth_hash)
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
  end

  context 'with a user who is already logged in' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      controller.stub(:current_user).and_return(user)
    end
    it 'redirects to catalog index path' do
      get provider
      response.should redirect_to(catalog_index_path)
    end
  end

  shared_examples 'Shibboleth login' do
    before(:each) do
      allow(User).to receive(:find_by_provider_and_uid).with(provider.to_s, uid).and_return(user)
      unless person.nil?
        person.profile = profile
        person.save
      end
    end
    it 'assigns the user and redirects' do
      get provider
      expect(flash[:notice]).to match(/You are now signed in as */)
      expect(assigns(:user)).to eq(user)
      expect(response).to be_redirect
    end
  end

  context 'with a brand new user' do
    let(:person) { FactoryGirl.create(:shibboleth_person) }
    let(:user) { FactoryGirl.create(:user, email: 'new.user@example.com') }
    let(:profile) { FactoryGirl.create(:shibboleth_profile) }
    it_behaves_like 'Shibboleth login'
  end

  context 'with a registered user who has previously logged in' do
    let(:person) { FactoryGirl.create(:shibboleth_person) }
    let(:user) { FactoryGirl.create(:shibboleth_user, count: 1, person_pid: person.pid) }
    let(:profile) { FactoryGirl.create(:shibboleth_profile) }
    it_behaves_like 'Shibboleth login'
  end

  context 'with a registered user who has never logged in' do
    let(:person) { FactoryGirl.create(:shibboleth_person) }
    let(:user) { FactoryGirl.create(:shibboleth_user, count: 0, person_pid: person.pid) }
    let(:profile) { FactoryGirl.create(:shibboleth_profile) }
    it_behaves_like 'Shibboleth login'
  end
end

