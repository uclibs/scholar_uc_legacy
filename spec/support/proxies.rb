# frozen_string_literal: true
module ProxiesHelper
  def create_proxy_using_partial(*users)
    users.each do |user|
      sleep(1)
      first('a.select2-choice').click
      find(".select2-input").set(user.user_key)
      expect(page).to have_css("div.select2-result-label")
      first("div.select2-result-label").click
    end
  end

  def submit_work_on_behalf_of(receiver)
    visit new_hyrax_generic_work_path
    title_element = find_by_id("generic_work_title")
    title_element.set("My proxy submitted work")
    fill_in('Creator', with: 'Grantor')
    fill_in('Description', with: 'A proxy deposited work')
    select 'Attribution-ShareAlike 4.0 International', from: "generic_work_rights"
    select(receiver.user_key, from: 'On behalf of')
    check('agreement')
    click_on('Save')
  end

  RSpec.configure do |config|
    config.include ProxiesHelper
  end
end
