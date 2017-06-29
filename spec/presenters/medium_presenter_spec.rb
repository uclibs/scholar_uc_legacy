# frozen_string_literal: true
require "rails_helper"

RSpec.describe MediumPresenter do
  let(:solr_document) { SolrDocument.new(work.to_solr) }
  let(:presenter) { described_class.new(solr_document, ability) }

  subject { described_class.new(double, double) }
  it { is_expected.to delegate_method(:college).to(:solr_document) }
  it { is_expected.to delegate_method(:department).to(:solr_document) }
end
