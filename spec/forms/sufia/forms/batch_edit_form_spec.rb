# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Sufia::Forms::BatchEditForm do
  let(:model) { GenericWork.new }
  let(:work1) { create :generic_work, title: ["title 1"], keyword: ["abc"], creator: ["Wilma"], language: ['en'], alt_description: 'description1', rights: ['rights1'], subject: ['subject1'], identifier: ['id1'], based_near: ['based_near1'], related_url: ['related_url1'] }
  let(:work2) { create :generic_work, title: ["title 2"], keyword: ["123"], creator: ["Fred"], publisher: ['Rand McNally'], language: ['en'], resource_type: ['bar'], alt_description: 'description2', rights: ['rights2'], subject: ['subject2'], identifier: ['id2'], based_near: ['based_near2'], related_url: ['related_url2'] }
  let(:batch) { [work1.id, work2.id] }
  let(:form) { described_class.new(model, ability, batch) }
  let(:ability) { Ability.new(user) }
  let(:user) { build(:user, display_name: 'Jill Z. User') }

  describe "#terms" do
    subject { form.terms }
    it do
      is_expected.to eq %i(creator college department alt_description rights alt_date_created
                           alternate_title subject geo_subject time_period language
                           required_software note related_url)
    end
  end

  describe "#model" do
    it "combines the models in the batch" do
      expect(form.model.creator).to match_array ["Wilma", "Fred"]
      expect(form.model.alt_description).to eq "description1"
      expect(form.model.rights).to match_array ["rights1", "rights2"]
      expect(form.model.subject).to match_array ["subject1", "subject2"]
      expect(form.model.language).to match_array ["en"]
      expect(form.model.related_url).to match_array ["related_url1", "related_url2"]
    end
  end

  describe ".build_permitted_params" do
    subject { described_class.build_permitted_params }
    it do
      is_expected.to eq [{ creator: [] },
                         :college,
                         :department,
                         :alt_description,
                         { rights: [] },
                         :alt_date_created,
                         { alternate_title: [] },
                         { subject: [] },
                         { geo_subject: [] },
                         { time_period: [] },
                         { language: [] },
                         :required_software,
                         :note,
                         { related_url: [] },
                         :version,
                         { permissions_attributes: [:type, :name, :access, :id, :_destroy] },
                         :on_behalf_of,
                         { collection_ids: [] },
                         :visibility_during_embargo,
                         :embargo_release_date,
                         :visibility_after_embargo,
                         :visibility_during_lease,
                         :lease_expiration_date,
                         :visibility_after_lease,
                         :visibility]
    end
  end
end
