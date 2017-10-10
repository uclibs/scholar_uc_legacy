# frozen_string_literal: true
require "rails_helper"

describe WorkLoader do
  before { allow(CharacterizeJob).to receive(:perform_later) }

  let(:user) { create(:user) }
  let!(:role1) { Sipity::Role.create(name: 'depositing') }
  let(:work_pid) { nil }
  let(:file_pid1) { nil }
  let(:file_pid2) { nil }
  let(:collection_ids) { nil }
  let(:member_work_ids) { nil }
  let(:editors) { nil }
  let(:readers) { nil }

  let(:files) do
    [
      {
        path:         "#{fixture_path}/world.png",
        title:        "World!",
        visibility:   "restricted",
        embargo_date: "",
        uri:          "",
        pid:          file_pid1
      },
      {
        path:         "#{fixture_path}/test_file.txt",
        title:        "Test file",
        visibility:   "open",
        embargo_date: "",
        uri:          "",
        pid:          file_pid2
      }
    ]
  end

  let(:attributes) do
    {
      pid:                      work_pid,
      work_type:                "article",
      submitter_email:          user.email,
      files:                    files,
      title:                    ["My title"],
      creator:                  ["Creator"],
      description:              "My description",
      college:                  "Libraries",
      department:               "Digital Collections",
      rights:                   "http://creativecommons.org/licenses/by-nc/4.0/",
      visibility:               "open",
      edit_access:              editors,
      read_access:              readers,
      member_of_collection_ids: collection_ids,
      member_work_ids:          member_work_ids
    }
  end

  subject { described_class.new(attributes) }

  it "instantiates the class with minimal required attributes" do
    expect(subject).to be_an_instance_of(described_class)
  end

  it "instantiates a new curation_concern" do
    expect(subject.curation_concern).to be_an_instance_of(Article)
  end

  it "builds an actor" do
    expect(subject.actor).to be_an_instance_of(Hyrax::Actors::ActorStack)
  end

  it "builds an ability" do
    expect(subject.ability).to be_an_instance_of(Ability)
  end

  it "creates uploaded files" do
    expect(subject.file_attributes).to be_an_instance_of(Array)
    expect(subject.file_attributes.length).to be(2)
    expect(subject.file_attributes.first[:uploaded_file]).to be_an_instance_of(Hyrax::UploadedFile)
  end

  describe "#create" do
    before { subject.create }
    it "saves the curation concern" do
      expect(subject.curation_concern.id).not_to be_nil
    end

    it "attaches the files" do
      expect(subject.curation_concern.file_sets.length).to be(2)
      expect(subject.curation_concern.file_sets.map(&:id)).not_to include(nil)
    end

    context "when collection membership is specified" do
      let!(:collection) { create(:collection) }
      let(:collection_ids) { [collection.id] }

      it "adds the curation concern to the collection" do
        expect(subject.curation_concern.member_of_collections.first.id).to eq collection.id
      end
    end

    context "when file pid is specified" do
      let(:file_pid2) { "bez2345" }
      it "saves with the specified pid " do
        expect(subject.curation_concern.file_sets.map(&:id)).to include(file_pid2)
      end
    end

    context "when work pid is specified" do
      let(:work_pid) { "foo1234" }
      it "saves with the specified pid " do
        expect(subject.curation_concern.id).to eq(work_pid)
      end
    end

    context "when file visibility is specified" do
      it "saves the file with the specified visibility" do
        expect(subject.curation_concern.file_sets.map(&:visibility)).to include("restricted")
      end
    end

    context "when editors are set" do
      let(:editors) { [create(:user).email, create(:user).email] }
      it "saves the work with the readers" do
        expect(subject.curation_concern.edit_users).to include(editors[0])
        expect(subject.curation_concern.edit_users).to include(editors[1])
      end
    end

    context "when a reader is set" do
      let(:readers) { create(:user).email }
      it "saves the work with the reader" do
        expect(subject.curation_concern.read_users).to include(readers)
      end
    end

    context "when a related work is set" do
      let(:related_work) { create(:article) }
      let(:member_work_ids) { related_work.id }
      it "saves the work with the relationship" do
        expect(subject.curation_concern.member_ids).to include(related_work.id)
      end
    end
  end
end
