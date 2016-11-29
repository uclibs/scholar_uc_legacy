# frozen_string_literal: true
require 'rails_helper'

feature 'Creating a new work', js: true do
  let(:user) { FactoryGirl.create(:user) }
  let(:second_user) { FactoryGirl.create(:user) }
  let(:file1) { File.open(fixture_path + '/world.png') }
  let(:file2) { File.open(fixture_path + '/image.gif') }

  before do
    allow(CharacterizeJob).to receive(:perform_later)
  end

  context 'when the user is not a proxy' do
    before do
      login_as user
      visit new_curation_concerns_work_path
    end

    it 'create a new work' do
      click_link "Files" # switch tab
      expect(page).to have_content "Add files"
      expect(page).to have_content "Browse cloud files" # with browse-everything enabled
      # expect(page).to have_content "Add folder"  -- only works in Chrome
      attach_file("files[]", File.dirname(__FILE__) + "/../../spec/fixtures/image.jp2", visible: false)
      attach_file("files[]", File.dirname(__FILE__) + "/../../spec/fixtures/jp2_fits.xml", visible: false)
      click_link "Description" # switch tab
      fill_in('Title', with: 'My Test Work')
      # checking for work_creator autofill, and also filling it in
      expect(page).to have_css(".work_creator", text: user.name_for_works)
      fill_in('Creator', with: 'Test User')
      fill_in('Keyword', with: 'tests')
      select 'Attribution-ShareAlike 3.0 United States', from: 'work_rights'
      choose('work_visibility_open')
      expect(page).to have_content('Please note, making something visible to the world (i.e. marking this as Public) may be viewed as publishing which could impact your ability to')
      check('agreement')
      click_on('Save')
      expect(page).to have_content('My Test Work')
      expect(page).to have_content "Any uploaded files are being processed by Scholar@UC in the background."
    end
  end

  context 'when the user is a proxy' do
    before do
      ProxyDepositRights.create!(grantor: second_user, grantee: user)
      login_as user
      visit new_curation_concerns_work_path
    end

    it "create a new work on-behalf-of deposit" do
      skip "on-behalf-of selector causes layout error with sticky footer bug"
      click_link "Files" # switch tab
      expect(page).to have_content "Add files"

      # Capybara/poltergeist don't dependably upload files, so we'll stub out the results of the uploader:
      attach_file("files[]", File.dirname(__FILE__) + "/../../spec/fixtures/image.jp2", visible: false)
      attach_file("files[]", File.dirname(__FILE__) + "/../../spec/fixtures/jp2_fits.xml", visible: false)

      click_link "Description" # switch tab
      fill_in('Title', with: 'My Test Work')
      # fill_in('Creator', with: 'Test User') // now autofilling this
      expect(page).to have_css(".work_creator", text: user.name_for_works)
      fill_in('Keyword', with: 'tests')
      select 'Attribution-ShareAlike 3.0 United States', from: 'work_rights'

      choose('work_visibility_open')
      expect(page).to have_content('Please note, making something visible to the world (i.e. marking this as Public) may be viewed as publishing which could impact your ability to')
      select(second_user.user_key, from: 'On behalf of')
      expect(page).to have_css(".work_creator", value: second_user.name_for_works)
      check('agreement')
      click_on('Save')

      expect(page).to have_content('My Test Work')
      expect(page).to have_content "Any uploaded files are being processed by Sufia in the background."

      click_link('Dashboard')
      click_link('Shares')

      click_link('Works Shared with Me')
      expect(page).to have_content "My Test Work"
      # TODO: Show the work details (owner email)
      # first('i.glyphicon-chevron-right').click
      # first('.expanded-details').click_link(second_user.email)
    end
  end
end
