# Generated via
#  `rails generate curation_concerns:work Image`
require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Create a Image' do
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
      visit new_curation_concerns_image_path
      fill_in 'Title', with: 'Test Image'
      click_button 'Create Image'
      expect(page).to have_content 'Test Image'
    end
  end
end
