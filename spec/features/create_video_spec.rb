# Generated via
#  `rails generate curation_concerns:work Video`
require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Create a Video' do
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
      visit new_curation_concerns_video_path
      fill_in 'Title', with: 'Test Video'
      click_button 'Create Video'
      expect(page).to have_content 'Test Video'
    end
  end
end
