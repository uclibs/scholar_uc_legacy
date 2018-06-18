# frozen_string_literal: true
require 'rails_helper'

class DownloadsController < ApplicationController
  include Hydra::Controller::DownloadBehavior
end

describe DownloadsController do
  describe "#content_options" do
    let(:file_set) { create(:file_set) }
    let(:file) { file_set.original_file }

    before do
      binary = StringIO.new("test")
      Hydra::Works::AddFileToFileSet.call(file_set, binary, :original_file, versioning: true)
      allow(controller).to receive(:default_file).and_return file
    end

    subject { controller.send(:content_options) }

    context 'when the file is a PDF' do
      before do
        allow(file).to receive(:mime_type).and_return 'application/pdf'
      end

      it 'has disposition set to "attachment"' do
        expect(subject[:disposition]).to eq 'attachment'
      end
    end

    context 'when the file is not a PDF' do
      before do
        allow(file).to receive(:mime_type).and_return 'image/jpeg'
      end

      it 'has disposition set to "inline"' do
        expect(subject[:disposition]).to eq 'inline'
      end
    end
  end
end
