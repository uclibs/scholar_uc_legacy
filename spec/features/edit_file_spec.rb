# frozen_string_literal: true
require 'rails_helper'

describe "Editing a file:", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:file_title) { 'Some kind of title' }
  let(:work) { FactoryGirl.build(:work, user: user) }
  let(:file_set) { FactoryGirl.create(:file_set, user: user, title: [file_title]) }
  let(:file) { File.open(fixture_path + '/test_file.txt') }

  before do
    sign_in user
    Hydra::Works::AddFileToFileSet.call(file_set, file, :original_file)
    work.ordered_members << file_set
    work.save!
  end

  context 'when the user tries to update file content, but forgets to select a file:' do
    it 'shows the edit page again' do
      visit edit_hyrax_file_set_path(file_set)
      click_link 'Versions'
      click_button 'Upload New Version'
      expect(page).to have_content "Edit #{file_title}"
    end
  end
end
