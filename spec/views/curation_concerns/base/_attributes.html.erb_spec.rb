# frozen_string_literal: true
require 'rails_helper'

describe 'curation_concerns/base/_attributes.html.erb' do
  let(:college) { 'Libraries' }
  let(:department) { 'Digital Repositories' }

  let(:solr_document) { SolrDocument.new(attributes) }
  let(:attributes) do
    {
      Solrizer.solr_name('has_model', :symbol) => ["GenericWork"],
      college_tesim: college,
      department_tesim: department
    }
  end
  let(:ability) { nil }
  let(:presenter) do
    GenericWorkPresenter.new(solr_document, ability)
  end
  let(:doc) { Nokogiri::HTML(rendered) }

  before do
    allow(view).to receive(:dom_class) { '' }

    render 'curation_concerns/base/attributes', presenter: presenter
  end

  it 'has links to search for other objects with the same metadata' do
    expect(rendered).to have_link(college, href: search_catalog_path('f[college_sim][]': college))
    expect(rendered).to have_link(department, href: search_catalog_path('f[department_sim][]': department))
  end
end
