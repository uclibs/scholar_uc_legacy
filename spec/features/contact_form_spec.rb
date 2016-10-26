# frozen_string_literal: true
require 'rails_helper'

describe "Sending an email via the contact form", type: :feature do
  before { sign_in(:user) }

  it "sends mail" do
    visit '/'
    click_link "Contact"
    expect(page).to have_content "Contact the Scholar@UC Team"
    fill_in "Your Name", with: "Test McPherson"
    fill_in "Your Email", with: "archivist1@example.com"
    fill_in "Message", with: "I am contacting you regarding ScholarSphere."
    fill_in "Subject", with: "My Subject is Cool"
    click_button "Send"
    expect(page).to have_content "Thank you for your message!"
  end
end
