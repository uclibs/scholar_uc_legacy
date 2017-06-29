# frozen_string_literal: true
require 'rails_helper'

describe 'hyrax/base/_attributes.html.erb' do
  let(:college) { 'Libraries' }
  let(:department) { 'Digital Repositories' }
  let(:related_url) { 'http://www.uc.edu' }
  let(:submitter) { FactoryGirl.create(:user) }

  let(:solr_document) { SolrDocument.new(attributes) }
  let(:attributes) do
    {
      Solrizer.solr_name('has_model', :symbol) => ["GenericWork"],
      college_tesim: college,
      department_tesim: department,
      related_url_tesim: related_url,
      depositor_tesim: submitter.email
    }
  end
  let(:ability) { nil }
  let(:presenter) do
    GenericWorkPresenter.new(solr_document, ability)
  end
  let(:doc) { Nokogiri::HTML(rendered) }

  before do
    allow(view).to receive(:dom_class) { '' }

    render 'hyrax/base/attributes', presenter: presenter
  end

  it 'has links to search for other objects with the same metadata' do
    expect(rendered).to have_link(college, href: search_catalog_path('f[college_sim][]': college))
    expect(rendered).to have_link(department, href: search_catalog_path('f[department_sim][]': department))
    expect(rendered).to have_link(related_url)
    expect(rendered).to have_link(href: hyrax.profile_path(submitter))
  end
end
