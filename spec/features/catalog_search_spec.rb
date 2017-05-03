# frozen_string_literal: true
require 'rails_helper'
describe 'catalog searching', type: :feature do
  before do
    allow(User).to receive(:find_by_user_key).and_return(stub_model(User, twitter_handle: 'bob'))
    sign_in :user
    visit '/dashboard'
    find('#search-form-header').native.attributes['action'].value = '/catalog'
  end

  context 'with works and collections' do
    let!(:jills_work) do
      FactoryGirl.create(:public_work, title: ["Jill's Research"], description: ["Jill's abstract"], keyword: ['jills_keyword', 'shared_keyword'])
    end

    let!(:jacks_work) do
      FactoryGirl.create(:public_work, title: ["Jack's Research"], description: ["Jack's abstract"], keyword: ['jacks_keyword', 'shared_keyword'])
    end

    let!(:collection) { FactoryGirl.create(:public_collection, title: ["Jack and Jill's collection"], description: ["This is a collection"], keyword: ['collection_keyword', 'shared_keyword']) }

    it 'performing a search' do
      within('#search-form-header') do
        fill_in('search-field-header', with: 'shared_keyword')
        click_button('Go')
      end
      expect(page).to have_content(jills_work.class)
      expect(page).to have_content(jills_work.title.first)
      expect(page).to have_content(jills_work.description.first)
      expect(page).to have_content(jills_work.creator.first)
      expect(page).to have_content(jacks_work.class)
      expect(page).to have_content(jacks_work.title.first)
      expect(page).to have_content(jacks_work.description.first)
      expect(page).to have_content(jacks_work.creator.first)
      expect(page).to have_content(collection.class)
      expect(page).to have_content(collection.title.first)
      expect(page).to have_content(collection.description.first)
      expect(page).to have_content(collection.creator.first)
    end
  end
end
