# frozen_string_literal: true
require 'rails_helper'

describe 'proxy', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:second_user) { FactoryBot.create(:user, first_name: 'Proxy') }
  let(:profile_path) { Hyrax::Engine.routes.url_helpers.profile_path(user) }
  let!(:role1) { Sipity::Role.create(name: 'depositing') }
  let(:work_id) { GenericWork.where(title: 'My Proxy Submitted Work') }

  describe 'add and remove proxy in profile', :js do
    before do
      page.driver.browser.js_errors = false
    end

    it "creates and removes a proxy" do
      # Create Proxy
      sign_in user
      visit profile_path
      click_link('Edit Profile', match: :first)
      expect(first("td.depositor-name")).to be_nil
      create_proxy_using_partial(second_user)
      expect(page).to have_css('td.depositor-name', text: second_user.name)
      logout

      # Create Work As Proxy
      sign_in second_user
      submit_work_on_behalf_of user
      work_path = page.current_path
      logout

      # Remove Proxy
      sign_in user
      visit profile_path
      click_link('Edit Profile', match: :first)
      expect(page).to have_css('td.depositor-name', text: second_user.name)
      find('a.remove-proxy-button').click
      expect(page).not_to have_css('td.depositor-name', text: second_user.name)

      # Comfirm Ex-Proxy Can No Longer Edit Work
      visit work_path
      click_link 'Edit'
      click_link 'Share'
      expect(page).not_to have_text second_user.email
    end
  end
end
