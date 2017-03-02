# frozen_string_literal: true
require 'rails_helper'

describe 'searching' do
  let(:user) { FactoryGirl.create :user }
  let(:subject_value) { 'mustache' }
  let!(:work) do
    FactoryGirl.create(:public_work,
                       description: [subject_value],
                       title: ["Toothbrush"],
                       user: user)
  end

  let!(:collection) do
    create(:public_collection, title: ['collection title abc'], description: [subject_value], user: user, members: [work])
  end

  context "as a public user" do
    it "using the gallery view" do
      visit '/'
      fill_in "search-field-header", with: "Toothbrush"
      click_button "search-submit-header"
      expect(page).to have_content "1 entry found"
      within "#search-results" do
        expect(page).to have_content "Toothbrush"
      end

      click_link "Gallery"
      expect(page).to have_content "You searched for: Toothbrush"
      within "#documents" do
        expect(page).to have_content "Toothbrush"
      end
    end

    it "only searches all" do
      visit '/'
      expect(page).to have_content("All")
      expect(page).to have_css("a[data-search-label*=All]", visible: false)
      expect(page).not_to have_css("a[data-search-label*='My Works']", visible: false)
      expect(page).not_to have_css("a[data-search-label*='My Collections']", visible: false)
      expect(page).not_to have_css("a[data-search-label*='My Highlights']", visible: false)
      expect(page).not_to have_css("a[data-search-label*='My Shares']", visible: false)

      click_button("All")
      expect(page).to have_content("All of Scholar")
      fill_in "search-field-header", with: subject_value
      click_button("Go")

      expect(page).to have_content('Search Results')
      expect(page).to have_content('Toothbrush')
      expect(page).to have_content('collection title abc')
      expect(page).to have_css("span.collection-icon-search")
    end

    it "does not display search options for dashboard files" do
      visit "/"
      within(".input-group-btn") do
        expect(page).not_to have_content("My Works")
        expect(page).not_to have_content("My Collections")
        expect(page).not_to have_content("My Shares")
      end
    end

    it "displays browse button on home page" do
      visit '/'
      skip 'waiting for rebranding of home page' do
        expect(page).to have_link("Browse", href: main_app.search_catalog_path)
      end
    end

    it "displays browse button on ancillary pages" do
      visit help_path
      expect(page).to have_link("Browse", href: main_app.search_catalog_path)
    end
  end
end
