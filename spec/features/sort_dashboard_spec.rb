# frozen_string_literal: true
require 'rails_helper'

describe 'dashboard works sorting', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  let!(:work1) { create(:work, title: ["Alpha Kong"], user: user) }
  let!(:work2) { create(:work, title: ["Zeta Kong"], user: user) }

  before do
    sign_in user
    visit "/dashboard/works"
  end

  it "allows changing sort order" do
    find(:xpath, "//select[@id='sort']/option[contains(., 'title')][contains(@value, 'asc')]") \
      .select_option
    click_button('Refresh')
    expect(page).to have_css("#document_#{work1.id}")
    expect(page).to have_css("#document_#{work2.id}")
    expect(page.body.index("id=\"document_#{work1.id}")).to be < page.body.index("id=\"document_#{work2.id}")

    find(:xpath, "//select[@id='sort']/option[contains(., 'title')][contains(@value, 'desc')]") \
      .select_option
    click_button('Refresh')
    expect(page).to have_css("#document_#{work1.id}")
    expect(page).to have_css("#document_#{work2.id}")
    expect(page.body.index("id=\"document_#{work2.id}")).to be < page.body.index("id=\"document_#{work1.id}")
  end
end
