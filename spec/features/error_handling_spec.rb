require 'spec_helper'

describe 'Rescued exception' do
  let!(:public_person) {FactoryGirl.create(:person_with_user)}
  let(:user) {public_person.user}

  before do
    Rails.application.config.consider_all_requests_local = false
    Rails.application.config.action_dispatch.show_exceptions = true
    Curate.configuration.application_root_url = "https://scholar.uc.edu/"
    load "application_controller.rb"
  end

  after do
    Rails.application.config.consider_all_requests_local = true
    Rails.application.config.action_dispatch.show_exceptions = false
    Curate.configuration.application_root_url = "http://localhost:3000/"
    load "application_controller.rb"
  end

  it 'logs a detailed error message' do
    expect(Rails.logger).to receive(:error).with(/Rescued exception/)
    visit edit_curation_concern_article_path(id: 'invalid')
  end

  it 'renders the 404 page' do
    visit edit_curation_concern_article_path(id: 'invalid')
    expect(page.status_code).to eq(404)
  end

  shared_examples 'notification_alert' do
    it 'sends a notification alert' do
      email = ActionMailer::Base.deliveries.last
      expect(email.to).to eq(["scholar@uc.edu"])
      expect(email.from).to eq(["scholar@uc.edu"])
      expect(email.subject).to eq("Scholar@UC: Exception Alert")
      expect(email.body.raw_source).to include("Rescued exception")
    end
  end

  shared_examples 'no_notification_alert' do
    it 'does not send a notification alert' do
      email = ActionMailer::Base.deliveries.last
      expect(email).to be_nil
    end
  end

  context 'When the user is unauthenticated and the exception is not trival' do
    before do
      visit saved_searches_path # generates an exception not in the trivial list
    end

    it_behaves_like 'notification_alert'
  end

  context 'When the user is logged in and the exception is trivial' do
    before do
      login_as(user)
      visit edit_curation_concern_article_path(id: 'invalid')
    end

    it_behaves_like 'notification_alert'
  end

  context 'When the user is logged in and the exception is not trivial' do
    let!(:public_person) {FactoryGirl.create(:person_with_user)}
    let(:user) {public_person.user}
    before do
      login_as(user)
      visit citation_catalog_path # generates an exception not in the trivial list
    end

    it_behaves_like 'notification_alert'
  end

  context 'When the user is unauthenticated and the exception is trivial' do
    before do
      ActionMailer::Base.deliveries.clear
      visit edit_curation_concern_article_path(id: 'invalid')
    end

    it_behaves_like 'no_notification_alert'
  end

  context 'When the server is not scholar.uc.edu' do
    before do
      Curate.configuration.application_root_url = "http://localhost:3000/"
      ActionMailer::Base.deliveries.clear
      login_as(user)
      visit edit_curation_concern_article_path(id: 'invalid')
    end

    after do
      Curate.configuration.application_root_url = "https://scholar.uc.edu/"
    end

    it_behaves_like 'no_notification_alert'
  end
end
