# frozen_string_literal: true
require 'rails_helper'

describe 'collection', type: :feature, js: true do
  let(:user) { FactoryGirl.create(:user) }

  let(:collection) { FactoryGirl.create(:public_collection, user: user) }

  describe 'create collection' do
    before do
      admin = Role.create(name: "admin")
      admin.users << user
      admin.save
      sign_in user
    end

    let(:title) { "Test Collection" }
    let(:description) { "Description for collection we are testing." }

    it "makes a new collection" do
      visit '/'
      expect(page).to have_content('No collections have been featured')
      visit '/dashboard'
      first('#hydra-collection-add').click
      expect(page).to have_content 'Create New Collection'
      expect(page).to have_selector "input.collection_creator.multi_value"
      expect(page).to have_selector "input#collection_title"

      attach_file("collection[avatar]", File.dirname(__FILE__) + "/../../spec/fixtures/world.png", visible: false)
      fill_in('Title', with: title)
      fill_in('Description', with: description)
      fill_in('Creator', with: 'User name')
      choose 'Public'

      click_button("Create Collection")
      expect(page).to have_css("img[src*='world.png']")
      expect(page).to have_content 'Items in this Collection'
      expect(page).to have_content title
      expect(page).to have_content description

      click_link("Feature")
      visit '/'
      expect(page).to have_css("img[src*='world.png']")
    end
  end
end
