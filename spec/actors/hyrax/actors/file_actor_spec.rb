# frozen_string_literal: true
require 'rails_helper'

describe Hyrax::Actors::FileActor do
  include ActionDispatch::TestProcess
  include Hyrax::FactoryHelpers

  let(:user) { create(:user) }
  let(:file_set) { create(:file_set) }
  let(:relation) { create(:file_set) }
  let(:actor) { described_class.new(file_set, 'remastered', user) }
  let(:uploaded_file) { fixture_file_upload('/world.png', 'image/png') }
  let(:working_file) { Hyrax::WorkingDirectory.copy_file_to_working_directory(uploaded_file, file_set.id) }

  describe '#ingest_file' do
    let(:ingest_options) { { mime_type: 'image/png', relation: 'remastered', filename: 'world.png' } }

    context "when the file is available locally" do
      it 'calls ingest file job' do
        expect(IngestFileJob).to receive(:perform_later).with(file_set, uploaded_file.path, user, ingest_options)
        expect(Hyrax::WorkingDirectory).not_to receive(:copy_file_to_working_directory)
        actor.ingest_file(uploaded_file, true)
      end
    end

    context "when the file is not available locally" do
      before do
        allow(actor).to receive(:working_file).with(uploaded_file).and_return(working_file)
      end
      it 'calls ingest file job' do
        expect(IngestFileJob).to receive(:perform_later).with(file_set, /world\.png$/, user, ingest_options)
        actor.ingest_file(uploaded_file, true)
      end
    end

    context "when performing the ingest synchronously" do
      it 'calls ingest file job' do
        expect(IngestFileJob).to receive(:perform_now).with(file_set, uploaded_file.path, user, ingest_options)
        actor.ingest_file(uploaded_file, false)
      end
    end
  end

  describe "ingest_options" do
    let(:file_set_filename) { 'testfile.txt' }

    context "when the file does respond to :original_filename" do
      it "uses the :original_filename for the filename" do
        my_object = described_class.new(file_set, relation, user)
        expect(my_object.send(:ingest_options, uploaded_file, file_set_filename)[:filename]).to be uploaded_file.original_filename
      end
    end

    context "when the file does not respond to :original_filename" do
      it "uses the passed file_set_filename for the filename" do
        allow(uploaded_file).to receive(:respond_to?).and_return(false)
        my_object = described_class.new(file_set, relation, user)
        expect(my_object.send(:ingest_options, uploaded_file, file_set_filename)[:filename]).to be file_set_filename
      end
    end
  end

  describe "file_set_filename" do
    context "when the file_set does not have an import_url" do
      it "returns the file_set.label" do
        my_object = described_class.new(file_set, relation, user)
        expect(my_object.send(:file_set_filename)).to be file_set.label
      end
    end

    context "when the file_set has an import_url" do
      let(:return_header) { { 'content-disposition' => 'attachment\;filename="testfile.txt"\;filename*=UTF-8\'\'testfile.txt' } }

      before do
        allow(file_set).to receive(:import_url).and_return('http://example.com')
        WebMock.stub_request(:get, 'http://example.com').to_return(headers: return_header)
      end

      it "returns the filename from the header" do
        my_object = described_class.new(file_set, relation, user)
        expect(my_object.send(:file_set_filename)).to eq 'testfile.txt'
      end
    end
  end
end
