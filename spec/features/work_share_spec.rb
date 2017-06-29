# frozen_string_literal: true
require 'rails_helper'

shared_examples 'hide share feature' do |work_class| # snake-case work type for string interpolation
  let(:work_type) { work_class.name.underscore }
  let(:user) { create(:user) }
  before do
    sign_in user
  end

  it 'does not display group share feature' do
    visit new_polymorphic_path(work_class)
    click_link "Share"
    expect(page).not_to have_content('Share work with groups of users')
  end
end

describe "work share partial" do
  it_behaves_like "hide share feature", GenericWork
  it_behaves_like "hide share feature", Medium
  it_behaves_like "hide share feature", Image
  it_behaves_like "hide share feature", Document
  it_behaves_like "hide share feature", Article
  it_behaves_like "hide share feature", StudentWork
  it_behaves_like "hide share feature", Etd
  it_behaves_like "hide share feature", Dataset
end
