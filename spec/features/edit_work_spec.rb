# frozen_string_literal: true
require 'rails_helper'

shared_examples 'edit work' do |work_class|
  let(:user) { FactoryGirl.create(:user) }
  let(:work) { FactoryGirl.build(:work, user: user) }
  let(:work_type) { work_class.name.underscore }
  let(:edit_path) { "concern/#{work_type}s/#{work.id}/edit" }
  before do
    sign_in user
    work.ordered_members << FactoryGirl.create(:file_set, user: user, title: ['ABC123xyz'])
    work.read_groups = []
    work.save!
  end

  context 'when the user changes permissions' do
    it 'confirms copying permissions to files using Sufia layout' do
      visit edit_path
      choose("#{work_type}_visibility_open")
      check('agreement')
      click_on('Save')
      expect(page).to have_content 'Apply changes to contents?'
      expect(page).not_to have_content "Powered by CurationConcerns"
    end
  end
end

feature 'Editing a work', type: :feature do
  it_behaves_like 'edit work', GenericWork
end
