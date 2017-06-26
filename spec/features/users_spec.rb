# frozen_string_literal: true
require 'rails_helper'

describe "User Profile", type: :feature do
  before do
    sign_in user
  end
  let(:user) { create(:user) }
  let(:profile_path) { Hyrax::Engine.routes.url_helpers.profile_path(user) }

  context 'when visiting user profile' do
    it 'renders page properly' do
      visit profile_path
      expect(page).to have_content(user.email)
      expect(page).to have_content('Edit Profile')
      expect(page).to have_content('View People')
    end
  end

  context 'when editing user' do
    it 'renders identity and contact fields' do
      visit profile_path
      click_link('Edit Profile', match: :first)
      expect(page).to have_field('First name', with: user.first_name)
      expect(page).to have_field('Last name', with: user.last_name)
      expect(page).to have_field('Job title')
      expect(page).to have_field('Department')
      expect(page).to have_field('UC affiliation')
      expect(page).to have_field('Email', with: user.email)
      expect(page).to have_field('Alternate email')
      expect(page).to have_field('Campus phone number')
      expect(page).to have_field('Alternate phone number')
      expect(page).to have_field('Personal webpage')
      expect(page).to have_field('Blog')
    end

    it 'renders manage proxies partial' do
      visit profile_path
      click_link('Edit Profile', match: :first)
      expect(page).to have_content('Manage Proxies')
      expect(page).to have_content("Please Note: Your proxies can do anything on your behalf in Scholar@UC.")
    end

    it 'renders ORCID connector' do
      skip "Needs orcid gem upgrade" do
        visit profile_path
        click_link('Edit Profile', match: :first)
        expect(page).to have_content('Create or Connect your ORCID iD')
      end
    end
  end

  context 'when clicking view people' do
    # TODO: Move this to a view test

    before do
      visit profile_path
      click_link 'View People'
    end

    it "has a Search People field label" do
      expect(page).to have_css("label", text: "Search People")
    end

    it "has People in the heading" do
      expect(page).to have_css("h1", text: "People")
    end

    context "when the user doesn't own works" do
      it 'does not include the user in the display' do
        visit profile_path
        click_link 'View People'
        expect(page).not_to have_xpath("//td/a[@href='#{profile_path}']")
      end
    end

    context "when the user owns works" do
      let!(:work) { FactoryGirl.create(:work, user: user) }
      it 'includes the user in the display' do
        visit profile_path
        click_link 'View People'
        expect(page).to have_xpath("//td/a[@href='#{profile_path}?locale=en']")
      end
    end

    context "when the user is an admin" do
      before do
        admin = Role.create(name: "admin")
        admin.users << user
        admin.save
      end
      it 'includes the user without works in the display' do
        visit profile_path
        click_link 'View People'
        expect(page).to have_xpath("//td/a[@href='#{profile_path}?locale=en']")
      end
    end
  end

  context 'when visiting user profile' do
    it 'page should be editable' do
      visit profile_path
      click_link('Edit Profile', match: :first)
      fill_in 'Campus phone number', with: '513-867-5309'
      click_button 'Save Profile'
      expect(page).to have_content 'Your profile has been updated'
      expect(page).to have_link('513-867-5309', href: 'wtai://wp/mc;513-867-5309')
    end
  end

  context 'user profile' do
    let!(:dewey) { create(:user, display_name: 'Melvil Dewey') }
    let(:dewey_path) { Hyrax::Engine.routes.url_helpers.profile_path(dewey) }
    let!(:work) { FactoryGirl.create(:work, user: user) }
    let!(:work2) { FactoryGirl.create(:work, user: dewey) }

    it 'is searchable' do
      visit profile_path
      click_link 'View People'
      expect(page).to have_xpath("//td/a[@href='#{profile_path}?locale=en']")
      expect(page).to have_xpath("//td/a[@href='#{dewey_path}?locale=en']")
      fill_in 'user_search', with: 'Dewey'
      click_button "user_submit"
      expect(page).not_to have_xpath("//td/a[@href='#{profile_path}?locale=en']")
      expect(page).to have_xpath("//td/a[@href='#{dewey_path}?locale=en']")
    end
  end
end
