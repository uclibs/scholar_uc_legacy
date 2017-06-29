# frozen_string_literal: true
require 'rails_helper'

describe 'hyrax/file_sets/_actions', type: :view do
  before do
    allow(view).to receive_messages(blacklight_config: CatalogController.blacklight_config,
                                    blacklight_configuration_context: Blacklight::Configuration::Context.new(controller))
    allow(Hyrax.config).to receive(:display_media_download_link) { true }
    allow(view).to receive(:can?).and_return(true)
  end

  let(:depositor) do
    stub_model(User,
               user_key: 'bob',
               twitter_handle: 'bot4lib')
  end

  let(:small_solr_document) { SolrDocument.new(id: '123456', file_size_is: '3221225472') }

  let(:small_file) do
    stub_model(FileSet, id: '123',
                        depositor: depositor.user_key,
                        audit_stat: 1,
                        title: ['Small File'],
                        description: ['Lorem ipsum lorem ipsum. http://my.link.com'],
                        mime_type: 'application/binary',
                        has?: false,
                        solr_document: small_solr_document)
  end

  let(:large_solr_document) { SolrDocument.new(id: '234567', file_size_is: '3221225473') }

  let(:large_file) do
    stub_model(FileSet, id: '456',
                        depositor: depositor.user_key,
                        audit_stat: 1,
                        title: ['Large File'],
                        description: ['Lorem ipsum lorem ipsum. http://my.link.com'],
                        mime_type: 'application/binary',
                        has?: false,
                        solr_document: large_solr_document)
  end

  context 'when the file is smaller than the max download size' do
    before do
      render 'hyrax/file_sets/actions', file_set: small_file
    end

    it 'renders the download file link' do
      expect(rendered).to have_link 'Download "Small File"'
    end
  end

  context 'when the image is larger than the max download size' do
    before do
      render 'hyrax/file_sets/actions', file_set: large_file
    end

    it 'renders the request image link' do
      expect(rendered).to have_link 'Request this file'
    end
  end
end
