# frozen_string_literal: true
require "rails_helper"

describe CollectionLoader do
  let(:user) { create(:user) }
  let(:collection_pid) { nil }
  let(:avatar_path) { nil }

  let(:attributes) do
    {
      pid:             collection_pid,
      submitter_email: user.email,
      title:           ["A Large Collection"],
      description:     "My description",
      creator:         ["Ono, Santa"],
      rights:          "http://creativecommons.org/licenses/by-nc/4.0/",
      visibility:      "open",
      avatar_path:     avatar_path
    }
  end

  subject { described_class.new(attributes) }

  it "instantiates the #{described_class}" do
    expect(subject).to be_an_instance_of(described_class)
  end

  it "instantiates the collection with attributes" do
    expect(subject.collection).to be_an_instance_of(Collection)

    expect(subject.collection.title).to       eq(attributes[:title])
    expect(subject.collection.description).to eq([attributes[:description]])
    expect(subject.collection.creator).to     eq(attributes[:creator])
    expect(subject.collection.rights).to      eq([attributes[:rights]])
    expect(subject.collection.visibility).to  eq(attributes[:visibility])
    expect(subject.collection.depositor).to   eq(attributes[:submitter_email])
  end

  describe "#create" do
    before { subject.create }
    it "saves the collection" do
      expect(subject.collection.id).not_to be_nil
    end

    context "when an id is specified" do
      let(:collection_pid) { "foo1234" }
      it "saves the collection with that id" do
        expect(subject.collection.id).to eq(collection_pid)
      end
    end

    context "when an avatar is specified" do
      let(:avatar_path) { "#{fixture_path}/world.png" }
      let(:avatar_filename) { File.basename avatar_path }
      let(:collection_avatar_filename) do
        CollectionAvatar.where(collection_id: subject.collection.id).first.avatar.filename
      end

      it "associates the avatar with the collection" do
        expect(collection_avatar_filename).to eq(avatar_filename)
      end
    end
  end
end
