# frozen_string_literal: true
require "rails_helper"

RSpec.describe ImagePresenter do
  let(:solr_document) { SolrDocument.new(work.to_solr) }
  let(:presenter) { described_class.new(solr_document, ability) }

  subject { described_class.new(double, double) }
  it { is_expected.to delegate_method(:college).to(:solr_document) }
  it { is_expected.to delegate_method(:department).to(:solr_document) }
  it { is_expected.to delegate_method(:title).to(:solr_document) }
  it { is_expected.to delegate_method(:alternate_title).to(:solr_document) }
  it { is_expected.to delegate_method(:geo_subject).to(:solr_document) }
  it { is_expected.to delegate_method(:time_period).to(:solr_document) }
  it { is_expected.to delegate_method(:required_software).to(:solr_document) }
  it { is_expected.to delegate_method(:note).to(:solr_document) }
  it { is_expected.to delegate_method(:alt_description).to(:solr_document) }
  it { is_expected.to delegate_method(:alt_date_created).to(:solr_document) }

  describe '#members_include_viewable_image?' do
    let(:user_key) { 'a_user_key' }
    let(:attributes) do
      { "id" => '888888',
        "title_tesim" => ['foo', 'bar'],
        "human_readable_type_tesim" => ["Generic Work"],
        "has_model_ssim" => ["GenericWork"],
        "date_created_tesim" => ['an unformatted date'],
        "depositor_tesim" => user_key }
    end
    let(:solr_document) { SolrDocument.new(attributes) }
    let(:request) { double(host: 'example.org', base_url: 'http://example.org') }
    let(:ability) { double Ability }
    let(:presenter) { described_class.new(solr_document, ability, request) }
    let(:file_set_presenter) { Hyrax::FileSetPresenter.new(solr_document, ability) }
    let(:member_presenters) { [file_set_presenter] }

    subject { presenter.members_include_viewable_image? }

    before do
      allow(presenter).to receive(:member_presenters).and_return(member_presenters)
      allow(ability).to receive(:can?).with(:read, solr_document.id).and_return(read_permission)
    end

    context 'when the work has at least one viewable image' do
      let(:read_permission) { true }

      it { is_expected.to be true }
    end

    context 'when the work has no viewable images' do
      let(:read_permission) { false }

      it { is_expected.to be false }
    end
  end
end
