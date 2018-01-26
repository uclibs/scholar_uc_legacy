# frozen_string_literal: true
require 'rails_helper'

shared_examples 'edit work' do |work_class|
  let(:user) { FactoryBot.create(:user, first_name: 'John', last_name: 'Doe') }
  let!(:role1) { Sipity::Role.create(name: 'depositing') }
  let(:work) { FactoryBot.build(
    :work, user: user, creator: ['User, Different'],
           alt_description: 'test', college: "Business", department: "Marketing"
  ) }
  let(:work_type) { work_class.name.underscore }
  let(:edit_path) { "concern/#{work_type}s/#{work.id}/edit" }

  before do
    page.driver.browser.js_errors = false
    sign_in user
    work.ordered_members << FactoryBot.create(:file_set, user: user, title: ['ABC123xyz'])
    work.read_groups = []
    work.save!
  end

  context 'when the user changes permissions' do
    it 'confirms copying permissions to files using Hyrax layout' do
      visit edit_path
      expect(page).to have_field("generic_work[creator][]", id: "generic_work_creator", with: "User, Different")
      choose("#{work_type}_visibility_open")
      select 'All rights reserved', from: 'generic_work_rights'
      check('agreement')
      click_on('Save')
      expect(page).to have_content 'Apply changes to contents?'
      expect(page).not_to have_content "Powered by Hyrax"
    end
  end
end

shared_examples 'proxy edit work' do
  let(:user) { FactoryBot.create(:user) }
  let(:proxy) { FactoryBot.create(:user) }
  let!(:role1) { Sipity::Role.create(name: 'depositing') }

  let(:work_id) { GenericWork.where(title: 'My Proxy Submitted Work') }
  let(:profile_path) { Hyrax::Engine.routes.url_helpers.profile_path(user) }

  before do
    page.driver.browser.js_errors = false
    sign_in user
    visit profile_path
    click_link('Edit Profile', match: :first)
    create_proxy_using_partial(proxy)
    sleep(1)
    logout

    sign_in proxy
    submit_work_on_behalf_of(user)
  end

  it 'allows the proxy to edit a work submitted by the user' do
    expect(page).to have_link 'Edit'
    click_link 'Edit'
    expect(current_path).to include('edit')
    fill_in('Description', with: 'An edited proxy deposited work')
    fill_in('Creator', with: 'Edited grantor')
    page.save_screenshot('screenshot.png')

    click_on('Save')
    expect(current_path).to include('/concern/generic_works/')
    expect(page).to have_content('An edited proxy deposited work')
    expect(page).to have_content('Edited grantor')
  end
end

feature 'Editing a work', type: :feature, js: true do
  it_behaves_like 'edit work', GenericWork
end

feature 'Editing a work as a proxy', type: :feature, js: true do
  it_behaves_like 'proxy edit work', GenericWork
end
