# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Work`
require 'rails_helper'

describe User do
  describe "#name_for_works" do
    subject { described_class.new }

    context "with first_name and last_name set" do
      before do
        subject.first_name = "Lucy"
        subject.last_name = "Bearcat"
      end

      it "returns the name" do
        expect(subject.name_for_works).to eq("Bearcat, Lucy")
      end
    end

    context "with first_name blank and last_name set" do
      before do
        subject.last_name = "Bearcat"
      end

      it "returns the name" do
        expect(subject.name_for_works).to eq(nil)
      end
    end

    context "with first_name set and last_name blank" do
      before do
        subject.first_name = "Lucy"
      end

      it "returns the name" do
        expect(subject.name_for_works).to eq(nil)
      end
    end

    context "with first_name and last_name blank set" do
      it "returns the name" do
        expect(subject.name_for_works).to eq(nil)
      end
    end
  end

  shared_examples "user with name:" do |attrib|
    describe "#name_for_works" do
      subject { described_class.new }

      context "with first_name and last_name set" do
        before do
          subject.first_name = "Lucy"
          subject.last_name = "Bearcat"
        end

        it "returns the name" do
          expect(subject.send(attrib)).to eq("Lucy Bearcat")
        end
      end

      context "with first_name blank and last_name set" do
        before do
          subject.last_name = "Bearcat"
        end

        it "returns the name" do
          expect(subject.send(attrib)).to eq(subject.user_key)
        end
      end

      context "with first_name set and last_name blank" do
        before do
          subject.first_name = "Lucy"
        end

        it "returns the name" do
          expect(subject.send(attrib)).to eq(subject.user_key)
        end
      end

      context "with first_name and last_name blank set" do
        it "returns the name" do
          expect(subject.send(attrib)).to eq(subject.user_key)
        end
      end
    end
  end

  it_behaves_like "user with name:", :display_name
  it_behaves_like "user with name:", :name
end
