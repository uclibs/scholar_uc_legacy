# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work Article`
require 'rails_helper'

describe Article do
  describe ".human_readable_short_description" do
    let(:work) { described_class.new(title: ['demoname']) { |gw| gw.apply_depositor_metadata("user") } }
    it "has a human_readable_short_description" do
      expect(work.human_readable_short_description).to eq('Published or unpublished articles')
    end
  end

  describe ".properties" do
    subject { described_class.properties.keys }
    it { is_expected.to include("has_model", "create_date", "modified_date") }
  end

  describe "basic metadata" do
    before do
      allow(subject).to receive(:title).and_return(['foo'])
    end
    it "has dc properties" do
      expect(subject.title).to eq ['foo']
    end
  end

  describe "created for someone (proxy)" do
    let(:work) { described_class.new(title: ['demoname']) { |gw| gw.apply_depositor_metadata("user") } }
    let(:transfer_to) { create(:user) }

    it "transfers the request" do
      work.on_behalf_of = transfer_to.user_key
      expect(ContentDepositorChangeEventJob).to receive(:perform_later).once
      work.save!
    end
  end

  describe "delegations" do
    let(:work) { described_class.new { |gw| gw.apply_depositor_metadata("user") } }
    let(:proxy_depositor) { create(:user) }
    before do
      work.proxy_depositor = proxy_depositor.user_key
    end
    it "includes proxies" do
      expect(work).to respond_to(:relative_path)
      expect(work).to respond_to(:depositor)
      expect(work.proxy_depositor).to eq proxy_depositor.user_key
    end
  end

  describe "trophies" do
    let(:user) { create(:user) }
    let(:w) { create(:work, user: user) }
    let!(:t) { Trophy.create(user_id: user.id, work_id: w.id) }

    it "has a trophy" do
      expect(Trophy.where(work_id: w.id).count).to eq 1
    end
    it "removes all trophies when work is deleted" do
      w.destroy
      expect(Trophy.where(work_id: w.id).count).to eq 0
    end
  end

  describe "featured works" do
    let(:work) { create(:public_work) }
    before { FeaturedWork.create(work_id: work.id) }

    subject { work }
    it { is_expected.to be_featured }

    context "when a previously featured work is deleted" do
      it "deletes the featured work as well" do
        expect { work.destroy }.to change { FeaturedWork.all.count }.from(1).to(0)
      end
    end

    context "when the work becomes private" do
      it "deletes the featured work" do
        expect do
          work.visibility = Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE
          work.save!
        end.to change { FeaturedWork.all.count }.from(1).to(0)
        expect(work).not_to be_featured
      end
    end
  end

  describe "metadata" do
    it { should respond_to(:relative_path) }
    it { should respond_to(:depositor) }
    it { should respond_to(:related_url) }
    it { should respond_to(:part_of) }
    it { should respond_to(:creator) }
    it { should respond_to(:title) }
    it { should respond_to(:alternate_title) }
    it { should respond_to(:journal_title) }
    it { should respond_to(:issn) }
    it { should respond_to(:description) }
    it { should respond_to(:publisher) }
    it { should respond_to(:time_period) }
    it { should respond_to(:date_created) }
    it { should respond_to(:date_uploaded) }
    it { should respond_to(:date_modified) }
    it { should respond_to(:subject) }
    it { should respond_to(:geo_subject) }
    it { should respond_to(:required_software) }
    it { should respond_to(:note) }
    it { should respond_to(:language) }
    it { should respond_to(:rights) }
    it { should respond_to(:identifier) }
    it { should respond_to(:college) }
    it { should respond_to(:department) }
  end

  it_behaves_like 'is remotely identifiable by doi'
end
