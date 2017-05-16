# frozen_string_literal: true
require 'rails_helper'

describe 'hyrax/batch_uploads/_form.html.erb', type: :view do
  let(:work) { GenericWork.new }
  let(:ability) { double('ability', current_user: user) }
  let(:form) { Hyrax::Forms::BatchUploadForm.new(work, ability, controller) }
  let(:user) { stub_model(User) }

  before do
    allow(form).to receive(:payload_concern).and_return('GenericWork')
    stub_template "hyrax/base/_guts4form.html.erb" => "Form guts"
    assign(:form, form)
  end

  let(:page) do
    render
    Capybara::Node::Simple.new(rendered)
  end

  it "draws the page" do
    expect(page).to have_selector("form[action='/batch_uploads']")
    # No title, because it's captured per file (e.g. Display label)
    expect(page).not_to have_selector("input#generic_work_title")
    expect(view.content_for(:files_tab)).to have_link("Add New Generic Work", href: "/concern/generic_works/new")
  end
end
