# frozen_string_literal: true
require 'rails_helper'

describe 'New work with an infected file', js: true do
  let(:user) { FactoryGirl.create(:user) }
  before do
    allow(CharacterizeJob).to receive(:perform_later)
    allow(Hydra::Works::VirusCheckerService).to receive(:file_has_virus?).and_return(true)
    login_as user
    visit new_curation_concerns_work_path
  end

  it 'creates the work and drops the files' do
    click_link "Files" # switch tab
    expect(page).to have_content "Add files"
    attach_file("files[]", File.dirname(__FILE__) + "/../../spec/fixtures/image.jp2", visible: false)
    click_link "Description" # switch tab
    fill_in('Title', with: 'My Infected Work')
    fill_in('Creator', with: 'Test User')
    fill_in('Keyword', with: 'tests')
    select 'Attribution-ShareAlike 3.0 United States', from: 'work_rights'
    choose('work_visibility_open')
    check('agreement')
    click_on('Save')
    expect(page).to have_content('My Infected Work')
    expect(page).to have_content('A virus was detected in a file you uploaded.')
  end
end
