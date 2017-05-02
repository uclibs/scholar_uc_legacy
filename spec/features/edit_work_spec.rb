# frozen_string_literal: true
require 'rails_helper'

shared_examples 'edit work' do |work_class|
  let(:user) { FactoryGirl.create(:user, first_name: 'John', last_name: 'Doe') }
  let(:work) { FactoryGirl.build(:work, user: user, creator: ['User, Different'], description: ['test']) }
  let(:work_type) { work_class.name.underscore }
  let(:edit_path) { "concern/#{work_type}s/#{work.id}/edit" }
  before do
    CurationConcerns::Workflow::WorkflowImporter.load_workflows
    Sufia::AdminSetCreateService.create_default!
    page.driver.browser.js_errors = false
    sign_in user
    work.ordered_members << FactoryGirl.create(:file_set, user: user, title: ['ABC123xyz'])
    work.read_groups = []
    work.save!
  end

  context 'when the user changes permissions' do
    it 'confirms copying permissions to files using Sufia layout' do
      visit edit_path
      expect(page).to have_field("generic_work[creator][]", id: "generic_work_creator", with: "User, Different")
      choose("#{work_type}_visibility_open")
      check('agreement')
      click_on('Save')
      expect(page).to have_content 'Apply changes to contents?'
      expect(page).not_to have_content "Powered by CurationConcerns"
    end
  end
end

feature 'Editing a work', type: :feature, js: true do
  it_behaves_like 'edit work', GenericWork
end
