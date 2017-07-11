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

  it 'has text for open visibility' do
    expect(rendered).to have_text(t('hyrax.visibility.open.text'))
  end

  it 'has text for authenticated visibility' do
    expect(rendered).to have_text(t('hyrax.visibility.authenticated.text'))
  end

  it 'has text for embargo visibility' do
    expect(rendered).to have_text(t('hyrax.visibility.embargo.text'))
  end

  it 'has text for private visibility' do
    expect(rendered).to have_text(t('hyrax.visibility.private.text'))
  end
end
