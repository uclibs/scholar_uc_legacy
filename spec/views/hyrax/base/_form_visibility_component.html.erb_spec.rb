# frozen_string_literal: true
require 'rails_helper'

describe '/hyrax/base/_form_visibility_component.html.erb', type: :view do
  let(:work) { stub_model(GenericWork, id: '456', title: ["A nice work"]) }
  let(:ability) { double }

  let(:form) do
    Hyrax::GenericWorkForm.new(work, ability, controller)
  end

  let(:f) do
    view.simple_form_for(form, url: '/update') do |work_form|
      return work_form
    end
  end

  before do
    allow(view).to receive(:f).and_return(f)
    allow(f).to receive(:object).and_return(form)
    assign(:form, form)
    render
  end

  it 'does not have a Lease option for visibility' do
    expect(rendered).not_to have_selector('div#collapseLease')
  end

  it 'has open visibility text' do
    expect(rendered).to have_text 'Open Access'
  end

  it 'has open visibility note' do
    expect(rendered).to have_text 'Make available to all'
  end

  it 'has open visibility link to Creators Rights' do
    expect(rendered).to have_link('Creator\'s Rights', href: '/creators_rights')
  end

  it 'has authenticated visibility text' do
    expect(rendered).to have_text 'University of Cincinnati'
  end

  it 'has authenticated visibility note' do
    expect(rendered).to have_text 'Restrict access to logged-in users'
  end

  it 'has embargo visibility text' do
    expect(rendered).to have_text 'Embargo'
  end

  it 'has embargo visibility note' do
    expect(rendered).to have_text 'Set a date for future release'
  end

  it 'has private visibility text' do
    expect(rendered).to have_text 'Private'
  end

  it 'has private visibility note' do
    expect(rendered).to have_text 'Keep to myself with option to share'
  end
end
