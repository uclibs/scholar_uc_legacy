# frozen_string_literal: true
require 'rails_helper'

shared_examples "batch_form_fields" do |work_class|
  let(:work_form_class) { ("CurationConcerns::" + work_class.name + "Form").constantize }
  let(:work_name) { work_class.name }
  let(:subject) { Sufia::Forms::BatchUploadForm.new(BatchUploadItem.new, nil) }

  context "batch form" do
    let(:target) { work_form_class.new(work_class.new, nil) }
    before { subject.payload_concern = work_name }

    describe "#required_fields" do
      it "equals the terms for the payload" do
        skip # Fix this later
        expect(subject.required_fields).to eq(target.required_fields)
      end
    end

    describe "#primary_terms" do
      it "equals the terms for the payload" do
        skip # Fix this later
        expect(subject.primary_terms).to eq(target.primary_terms - [:title])
      end
    end

    describe "#secondary_terms" do
      it "equals the terms for the payload" do
        skip # Fix this later
        expect(subject.secondary_terms).to eq(target.secondary_terms)
      end
    end
  end
end

RSpec.describe Sufia::Forms::BatchUploadForm do
  Sufia.config.curation_concerns.each do |klass|
    it_behaves_like 'batch_form_fields', klass
  end

  let(:model) { GenericWork.new }
  let(:form) { described_class.new(model, ability) }
  let(:ability) { Ability.new(user) }
  let(:user) { build(:user, display_name: 'Jill Z. User') }

  describe ".model_name" do
    subject { described_class.model_name }
    it "has a route_key" do
      expect(subject.route_key).to eq 'batch_uploads'
    end
    it "has a param_key" do
      expect(subject.param_key).to eq 'batch_upload_item'
    end
  end

  describe "#to_model" do
    subject { form.to_model }
    it "returns itself" do
      expect(subject.to_model).to be_kind_of described_class
    end
  end

  describe "#terms" do
    let(:terms) do
      %i(creator alt_description right publisher alt_date_created subject
         language identifier based_near related_url representative_id
         thumbnail_id files visibility_during_embargo embargo_release_date
         visibility_after_embargo visibility_during_lease
         lease_expiration_date visibility_after_lease visibility
         ordered_member_ids in_works_ids collection_ids admin_set_id
         alternate_title journal_title issn time_period required_software
         committee_member note geo_subject doi doi_assignment_strategy existing_identifier
         college department genre degree advisor)
    end

    subject { form.terms }
    it { is_expected.to eq terms }
  end
end
