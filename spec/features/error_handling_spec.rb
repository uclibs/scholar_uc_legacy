require 'spec_helper'

describe 'Rescued exception' do
  before do
    Rails.application.config.consider_all_requests_local = false
    Rails.application.config.action_dispatch.show_exceptions = true
    load "application_controller.rb"
  end

  after do
    Rails.application.config.consider_all_requests_local = true
    Rails.application.config.action_dispatch.show_exceptions = false
    load "application_controller.rb"
  end

  it 'logs a detailed error message' do
    expect(Rails.logger).to receive(:error).with(/Rescued exception/)
    visit edit_curation_concern_article_path(id: 'invalid')
  end

  it 'sends a notification alert' do
    visit edit_curation_concern_article_path(id: 'invalid')
    email = ActionMailer::Base.deliveries.last
    expect(email.to).to eq(["scholar@uc.edu"])
    expect(email.from).to eq(["scholar@uc.edu"])
    expect(email.subject).to eq("Scholar@UC: Exception Alert")
    expect(email.body.raw_source).to include("Rescued exception")
  end

  it 'renders the 404 page' do
    visit edit_curation_concern_article_path(id: 'invalid')
    expect(page.status_code).to eq(404)
  end
end
