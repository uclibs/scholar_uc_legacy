# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work Work`
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

  subject { described_class.new(email: 'test@example.com', password: 'test1234') }

  context 'when a user is not a student' do
    before do
      subject.uc_affiliation = ''
    end
    it "returns false for .student?" do
      expect(subject.student?).to be false
    end
  end

  context 'when a user is a student' do
    before do
      subject.uc_affiliation = 'student'
    end
    it "returns true for .student?" do
      expect(subject.student?).to be true
    end
  end

  it "sets waived_welcome_page to true" do
    subject.save!
    subject.waive_welcome_page!
    expect(subject.waived_welcome_page).to be true
  end

  describe "college" do
    subject { described_class.new }

    context "when the user doesn't have a department" do
      it "returns Other" do
        subject.ucdepartment = nil
        expect(subject.college).to eq "Other"
      end
    end

    context "when the user has a department that starts with a college abbreviation" do
      it "returns the college abbreviation" do
        subject.ucdepartment = "UCL Test Department"
        expect(subject.college).to eq "Libraries"
      end
    end

    context "when the user has a department that doesn't start with a college abbreviation" do
      it "returns Other" do
        subject.ucdepartment = "Test Department"
        expect(subject.college).to eq "Other"
      end
    end
  end

  describe "department" do
    subject { described_class.new }

    context "when the user doesn't have a department" do
      it "returns Unknown" do
        subject.ucdepartment = nil
        expect(subject.department).to eq "Unknown"
      end
    end

    context "when the user has a department that starts with a college abbreviation" do
      it "returns the department without the abreviation" do
        subject.ucdepartment = "UCL Test Department"
        expect(subject.department).to eq "Test Department"
      end
    end

    context "when the user has a department that doesn't start with a college abbreviation" do
      it "returns the department without the abreviation" do
        subject.ucdepartment = "Test Department"
        expect(subject.department).to eq "Test Department"
      end
    end
  end
end
