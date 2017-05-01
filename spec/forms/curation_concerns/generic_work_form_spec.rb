# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work GenericWork`
require 'rails_helper'

RSpec.describe CurationConcerns::GenericWorkForm do
  let(:work) { GenericWork.new }
  let(:form) { described_class.new(work, nil) }

  describe "#required_fields" do
    subject { form.required_fields }
    it { is_expected.to eq [:title, :creator, :college, :department, :alt_description, :rights] }
  end

  describe "#primary_terms" do
    subject { form.primary_terms }
    it { is_expected.to eq [:title, :creator, :college, :department, :alt_description, :rights, :publisher] }
  end

  describe "#secondary_terms" do
    subject { form.secondary_terms }
    it do
      is_expected.to include(:alt_date_created, :alternate_title,
                             :subject, :geo_subject,
                             :time_period, :language,
                             :required_software, :note)
    end
  end

  describe '.model_attributes' do
    before { create(:permission_template, admin_set_id: admin_set_id, workflow_name: workflow.name) }
    let(:workflow) { create(:workflow) }
    let(:admin_set_id) { '123' }
    let(:params) do
      ActionController::Parameters.new(
        title: 'foo',
        alt_description: '',
        visibility: 'open',
        admin_set_id: admin_set_id,
        representative_id: '456',
        thumbnail_id: '789',
        rights: 'http://creativecommons.org/licenses/by/4.0/us/',
        collection_ids: ['123456', 'abcdef']
      )
    end

    subject { described_class.model_attributes(params) }

    it 'permits parameters' do
      expect(subject['title']).to eq ['foo']
      expect(subject['alt_description']).to eq ''
      expect(subject['visibility']).to eq 'open'
      expect(subject['rights']).to eq 'http://creativecommons.org/licenses/by/4.0/us/'
      expect(subject['collection_ids']).to eq ['123456', 'abcdef']
    end

    context '.model_attributes' do
      let(:params) do
        ActionController::Parameters.new(
          title: '',
          alt_description: '',
          rights: '',
          collection_ids: [''],
          on_behalf_of: 'Melissa'
        )
      end

      it 'removes blank parameters' do
        expect(subject['title']).to eq ['']
        expect(subject['alt_description']).to eq ''
        expect(subject['rights']).to be_empty
        expect(subject['collection_ids']).to be_empty
        expect(subject['on_behalf_of']).to eq 'Melissa'
      end
    end
  end

  describe "#visibility" do
    subject { form.visibility }
    it { is_expected.to eq 'restricted' }
  end

  subject { form }

  it { is_expected.to delegate_method(:on_behalf_of).to(:model) }
  it { is_expected.to delegate_method(:depositor).to(:model) }
  it { is_expected.to delegate_method(:permissions).to(:model) }

  describe "#agreement_accepted" do
    subject { form.agreement_accepted }
    it { is_expected.to eq false }
  end

  context "on a work already saved" do
    before { allow(work).to receive(:new_record?).and_return(false) }
    it "defaults deposit agreement to true" do
      expect(form.agreement_accepted).to eq(true)
    end
  end
end
