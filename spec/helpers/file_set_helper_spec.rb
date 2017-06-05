# frozen_string_literal: true
require 'rails_helper'
# include Devise::TestHelpers

describe FileSetHelper, type: :helper do
  let(:user) { FactoryGirl.create(:user) }
  let(:file_set) { FactoryGirl.create(:file_set, user: user, title: ['File Title']) }
  let(:button_text) { 'Request this file' }
  let(:small_solr_document) { SolrDocument.new(id: '123456', file_size_is: '3221225472') }
  let(:large_solr_document) { SolrDocument.new(id: '123456', file_size_is: '3221225473') }
  before do
    Rails.application.routes.default_url_options[:host] = "test.host"
  end

  describe 'show_request_file_button' do
    it 'renders the request file button' do
      expect(helper.show_request_file_button(file_set, button_text)).to have_link(button_text, href: "#{hyrax.contact_path}?#{helper.subject_and_message}#{main_app.root_url}#{hyrax.download_path(file_set)}")
    end
  end

  describe 'show_request_file_action' do
    it 'renders the request file action link' do
      expect(helper.show_request_file_action(file_set, button_text)).to have_link("Download #{file_set.to_s.inspect}", href: "#{hyrax.contact_path}?#{helper.subject_and_message}#{main_app.root_url}#{hyrax.download_path(file_set)}")
    end
  end

  describe 'subject_and_message' do
    it 'returns the subject and message query params' do
      expect(helper.subject_and_message).to have_content('subject=')
      expect(helper.subject_and_message).to have_content('message=')
    end
  end

  describe 'file_is_too_large_to_download' do
    context 'when the file is larger than the max download size' do
      before do
        allow(file_set).to receive(:solr_document).and_return(large_solr_document)
      end
      it 'returns true' do
        expect(helper.file_is_too_large_to_download(file_set)).to be true
      end
    end

    context 'when the file is smaller than the max download size' do
      before do
        allow(file_set).to receive(:solr_document).and_return(small_solr_document)
      end
      it 'returns false' do
        expect(helper.file_is_too_large_to_download(file_set)).to be false
      end
    end
  end
end
