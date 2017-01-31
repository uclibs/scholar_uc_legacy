# frozen_string_literal: true
require 'rails_helper'

shared_examples 'work creation' do |work_class| # snake-case work type for string interpolation
  let(:work_type) { work_class.name.underscore }

  it 'fills out the form as user' do
    visit new_polymorphic_path(work_class)
    click_link "Files" # switch tab
    expect(page).to have_content "Add files"
    expect(page).to have_content "Browse cloud files" # with browse-everything enabled
    # expect(page).to have_content "Add folder"  -- only works in Chrome
    attach_file("files[]", File.dirname(__FILE__) + "/../../spec/fixtures/image.jp2", visible: false)
    attach_file("files[]", File.dirname(__FILE__) + "/../../spec/fixtures/jp2_fits.xml", visible: false)
    click_link "Description" # switch tab
    fill_in('Title', with: 'My Test Work')
    fill_in('Creator', with: 'Test User')
    fill_in('Keyword', with: 'tests')
    select 'Attribution-ShareAlike 3.0 United States', from: "#{work_type}_rights"
    choose("#{work_type}_visibility_open")
    expect(page).to have_content('Please note, making something visible to the world (i.e. marking this as Public) may be viewed as publishing which could impact your ability to')
    check('agreement')
    click_on('Save')
    expect(page).to have_content('My Test Work')
    expect(page).to have_content "Any uploaded files are being processed by Scholar@UC in the background."
  end
end

shared_examples 'proxy work creation' do |work_class|
  let(:work_type) { work_class.name.underscore }

  it "fills out the #{work_class} form as proxy", :js do
    visit new_polymorphic_path(work_class)
    click_link "Files" # switch tab
    expect(page).to have_content "Add files"
    # Capybara/poltergeist don't dependably upload files, so we'll stub out the results of the uploader:
    attach_file("files[]", File.dirname(__FILE__) + "/../../spec/fixtures/image.jp2", visible: false)
    attach_file("files[]", File.dirname(__FILE__) + "/../../spec/fixtures/jp2_fits.xml", visible: false)
    click_link "Description" # switch tab
    fill_in('Title', with: 'My Test Work')
    fill_in('Creator', with: 'Test User')
    fill_in('Keyword', with: 'tests')
    select 'Attribution-ShareAlike 3.0 United States', from: "#{work_type}_rights"
    choose("#{work_type}_visibility_open")
    expect(page).to have_content('Please note, making something visible to the world (i.e. marking this as Public) may be viewed as publishing which could impact your ability to')
    select(second_user.user_key, from: 'On behalf of')
    check('agreement')
    click_on('Save')
    expect(page).to have_content('My Test Work')
    expect(page).to have_content "Any uploaded files are being processed by Scholar@UC in the background."
    click_link('Dashboard')
    click_link('Shares')
    click_link('Works Shared with Me')
    expect(page).to have_content "My Test Work"
  end
end

feature 'Creating a new work', :js do
  let(:user) { create(:user) }
  let(:file1) { File.open(fixture_path + '/world.png') }
  let(:file2) { File.open(fixture_path + '/image.jp2') }
  # Don't bother making these, until we unskip tests
  # let!(:uploaded_file1) { UploadedFile.create(file: file1, user: user) }
  # let!(:uploaded_file2) { UploadedFile.create(file: file2, user: user) }

  before do
    allow(CharacterizeJob).to receive(:perform_later)
    page.current_window.resize_to(2000, 2000)
  end

  context "when the user is not a proxy", :js do
    before do
      sign_in user
    end

    it_behaves_like "work creation", GenericWork
    it_behaves_like "work creation", Article
    it_behaves_like "work creation", Document
    it_behaves_like "work creation", Image
    it_behaves_like "work creation", Dataset
    it_behaves_like "work creation", Video
    it_behaves_like "work creation", Etd
    it_behaves_like "work creation", StudentWork
  end

  context 'when the user is a proxy' do
    let(:second_user) { create(:user) }
    before do
      ProxyDepositRights.create!(grantor: second_user, grantee: user)
      sign_in user
      click_link "Create Work"
    end
    it_behaves_like "proxy work creation", GenericWork
    it_behaves_like "proxy work creation", Video
    it_behaves_like "proxy work creation", Image
    it_behaves_like "proxy work creation", Document
    it_behaves_like "proxy work creation", Article
    it_behaves_like "proxy work creation", StudentWork
    it_behaves_like "proxy work creation", Etd
    it_behaves_like "proxy work creation", Dataset
  end
end
