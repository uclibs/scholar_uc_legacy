# frozen_string_literal: true
describe Hyrax::Forms::CollectionForm do
  let(:collection) { build(:collection) }
  let(:form) { described_class.new(collection) }

  describe "#primary_terms" do
    subject { form.primary_terms }
    it { is_expected.to eq([
                             :title,
                             :creator,
                             :description,
                             :rights
                           ]) }
  end

  describe "#secondary_terms" do
    subject { form.secondary_terms }

    it do
      is_expected.to eq []
    end
  end

  describe "#id" do
    subject { form.id }
    it { is_expected.to be_nil }
  end
end
