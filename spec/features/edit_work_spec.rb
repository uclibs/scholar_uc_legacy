# frozen_string_literal: true
require 'rails_helper'

feature 'Editing a work', type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:work) { FactoryGirl.build(:work, user: user) }

  before do
    sign_in user
    work.ordered_members << FactoryGirl.create(:file_set, user: user, title: ['ABC123xyz'])
    work.read_groups = []
    work.save!
  end

  context 'when the user changes permissions' do
    it 'confirms copying permissions to files using Sufia layout' do
      visit edit_curation_concerns_work_path(work)
      choose('work_visibility_open')
      check('agreement')
      click_on('Save')
      expect(page).to have_content 'Apply changes to contents?'
      expect(page).not_to have_content "Powered by CurationConcerns"
    end
  end
end
