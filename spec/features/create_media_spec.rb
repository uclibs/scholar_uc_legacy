# Generated via
#  `rails generate curation_concerns:work Media`
require 'rails_helper'
include Warden::Test::Helpers

feature 'Create a Media' do
  context 'a logged in user' do
    let(:user_attributes) do
      { email: 'test@example.com' }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end

    before do
      login_as user
    end

    scenario do
      visit new_curation_concerns_media_path
      fill_in 'Title', with: 'Test Media'
      click_button 'Create Media'
      expect(page).to have_content 'Test Media'
    end
  end
end
