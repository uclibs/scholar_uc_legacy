# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work Medium`
require 'rails_helper'

RSpec.describe Hyrax::MediumForm do
  let(:work) { Medium.new }
  let(:form) { described_class.new(work, nil, nil) }

  describe "#required_fields" do
    subject { form.required_fields }
    it { is_expected.to eq [:title, :creator, :college, :department, :alt_description, :rights] }
  end

  describe "#primary_terms" do
    subject { form.primary_terms }
    it { is_expected.to eq [:title, :creator, :college, :department,
                            :alt_description, :rights, :publisher,
                            :alt_date_created, :alternate_title,
                            :subject, :geo_subject,
                            :time_period, :language,
                            :required_software, :note, :related_url] }
  end

  describe '.model_attributes' do
    let(:permission_template) { create(:permission_template, admin_set_id: admin_set_id) }
    let!(:workflow) { create(:workflow, active: true, permission_template_id: permission_template.id) }
    let(:admin_set_id) { '123' }
    let(:params) do
      ActionController::Parameters.new(
        title: 'foo',
        alt_description: '',
        visibility: 'open',
        admin_set_id: admin_set_id,
        representative_id: '456',
        thumbnail_id: '789',
        keyword: ['derp'],
        rights: 'http://creativecommons.org/licenses/by/3.0/us/',
        member_of_collection_ids: ['123456', 'abcdef']
      )
    end

    subject { described_class.model_attributes(params) }

    it 'permits parameters' do
      expect(subject['title']).to eq ['foo']
      expect(subject['alt_description']).to eq ''
      expect(subject['visibility']).to eq 'open'
      expect(subject['rights']).to eq 'http://creativecommons.org/licenses/by/3.0/us/'
      expect(subject['member_of_collection_ids']).to eq ['123456', 'abcdef']
    end

    context '.model_attributes' do
      let(:params) do
        ActionController::Parameters.new(
          title: '',
          alt_description: '',
          rights: '',
          member_of_collection_ids: [''],
          on_behalf_of: 'Melissa'
        )
      end

      it 'removes blank parameters' do
        expect(subject['title']).to eq ['']
        expect(subject['alt_description']).to eq ''
        expect(subject['rights']).to be_empty
        expect(subject['member_of_collection_ids']).to be_empty
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
