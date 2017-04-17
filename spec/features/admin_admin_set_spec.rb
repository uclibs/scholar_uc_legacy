# frozen_string_literal: true
require 'rails_helper'

RSpec.describe "New admin set" do
  let(:user) { create :user }

  before do
    allow_any_instance_of(Ability).to receive(:user_groups).and_return(['admin'])
  end

  scenario do
    login_as(user)
    visit '/admin/admin_sets/new'
    within('#description') do
      fill_in "Title", with: 'The title'
      click_button 'Save'
    end
    expect(page).to have_content "The title"
  end
end
