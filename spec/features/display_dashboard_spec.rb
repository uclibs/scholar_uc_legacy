# frozen_string_literal: true
require 'rails_helper'

describe "The Dashboard", type: :feature do
  before do
    sign_in :user_with_fixtures
    click_link "Dashboard"
    click_link "My Dashboard"
  end

  context "upon sign-in" do
    it "shows the user's information" do
      expect(page).to have_content "My Dashboard"
      expect(page).to have_content "User Activity"
      expect(page).to have_content "User Notifications"
      expect(page).to have_content "My Collections"
      expect(page).to have_content "My Works"
    end

    it "lets the user create collections" do
      click_link "Create Collection"
      expect(page).to have_content "Create New Collection"
    end

    it "lets the user view works" do
      click_link "View My Works"
      expect(page).to have_content "My Works"
      expect(page).to have_content "My Collections"
      expect(page).to have_content "My Highlights"
      expect(page).to have_content "Works Shared with Me"
    end

    it "shows proxy information" do
      expect(page).to have_content "Manage Proxies"
      expect(page).to have_content "Please Note: Your proxies can do anything on your behalf in Scholar@UC."
    end
  end
end
