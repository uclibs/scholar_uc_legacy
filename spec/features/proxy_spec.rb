# frozen_string_literal: true
require 'rails_helper'

describe 'proxy', type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:second_user) { FactoryGirl.create(:user) }
  let(:profile_path) { Hyrax::Engine.routes.url_helpers.profile_path(user) }

  describe 'add proxy in profile', :js do
    it "creates a proxy" do
      sign_in user
      visit profile_path
      click_link('Edit Profile', match: :first)
      expect(first("td.depositor-name")).to be_nil
      create_proxy_using_partial(second_user)
      expect(page).to have_css('td.depositor-name', text: second_user.name)
    end
  end
end
