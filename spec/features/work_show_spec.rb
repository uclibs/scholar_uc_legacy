# frozen_string_literal: true
require 'rails_helper'

shared_examples 'submission form with form#fileupload' do |work_class|
  let(:work_type) { work_class.name.underscore }
  let(:work) { create("#{work_type}_with_one_file".to_sym, title: ["Magnificent splendor"], alt_description: "My description", source: ["The Internet"], based_near: ["USA"], user: user) }
  let(:user) { create(:user) }
  let(:work_path) { "/concern/#{work_type}s/#{work.id}" }

  before do
    sign_in user
    visit work_path
  end

  it "has metadata" do
    expect(page).to have_selector 'h1', text: 'Magnificent splendor'
    expect(page).to have_selector 'li', text: 'The Internet'
    expect(page).to have_selector 'th', text: 'Source'

    # Displays FileSets already attached to this work
    within '.related-files' do
      expect(page).to have_selector '.filename', text: 'A Contained FileSet'
    end
  end
end

shared_examples 'submission form without form#fileupload' do |work_class|
  let(:work) { create(:public_generic_work, title: ["Magnificent splendor"], alt_description: "My description", source: ["The Internet"]) }
  let(:work_type) { work_class.name.underscore }
  let(:work_path) { "/concern/#{work_type}s/#{work.id}" }
  before do
    visit work_path
  end

  it "has metadata" do
    expect(page).to have_selector 'h1', text: 'Magnificent splendor'
    expect(page).to have_selector 'li', text: 'The Internet'
    expect(page).to have_selector 'th', text: 'Source'

    # Doesn't have the upload form for uploading more files
    expect(page).not_to have_selector "form#fileupload"
  end

  it "has some social media buttons" do
    expect(page).to have_link '', href: "https://twitter.com/intent/tweet/?text=Magnificent+splendor&url=http%3A%2F%2Fwww.example.com%2Fconcern%2Fgeneric_works%2F#{work.id}"
  end
end

describe "display a work" do
  context "as the work owner" do
    it_behaves_like "submission form with form#fileupload", GenericWork
  end

  context "as a user who is not logged in" do
    it_behaves_like 'submission form without form#fileupload', GenericWork
  end
end
