# frozen_string_literal: true
require 'rails_helper'

describe 'hyrax/file_sets/media_display', type: :view do
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

  describe 'image' do
    context 'when the image is smaller than the max download size' do
      before do
        render 'hyrax/file_sets/media_display/image', file_set: small_file
      end

      it 'renders the download image link' do
        expect(rendered).to have_link t('hyrax.file_set.show.downloadable_content.image_link')
      end
    end

    context 'when the image is larger than the max download size' do
      before do
        render 'hyrax/file_sets/media_display/image', file_set: large_file
      end

      it 'renders the request image link' do
        expect(rendered).to have_link t('hyrax.file_set.show.requestable_content.image_link')
      end
    end
  end

  describe 'pdf' do
    context 'when the PDF is smaller than the max download size' do
      before do
        render 'hyrax/file_sets/media_display/pdf', file_set: small_file
      end

      it 'renders the download PDF link' do
        expect(rendered).to have_link t('hyrax.file_set.show.downloadable_content.pdf_link')
      end
    end

    context 'when the PDF is larger than the max download size' do
      before do
        render 'hyrax/file_sets/media_display/pdf', file_set: large_file
      end

      it 'renders the request PDF link' do
        expect(rendered).to have_link t('hyrax.file_set.show.requestable_content.pdf_link')
      end
    end
  end

  describe 'office_document' do
    context 'when the office document is smaller than the max download size' do
      before do
        render 'hyrax/file_sets/media_display/office_document', file_set: small_file
      end

      it 'renders the download office document link' do
        expect(rendered).to have_link t('hyrax.file_set.show.downloadable_content.office_link')
      end
    end

    context 'when the office document is larger than the max download size' do
      before do
        render 'hyrax/file_sets/media_display/office_document', file_set: large_file
      end

      it 'renders the request office document link' do
        expect(rendered).to have_link t('hyrax.file_set.show.requestable_content.office_link')
      end
    end
  end

  describe 'video' do
    context 'when the video is smaller than the max download size' do
      before do
        render 'hyrax/file_sets/media_display/video', file_set: small_file
      end

      it 'renders the download video link' do
        expect(rendered).to have_link t('hyrax.file_set.show.downloadable_content.video_link')
      end
    end

    context 'when the video is larger than the max download size' do
      before do
        render 'hyrax/file_sets/media_display/video', file_set: large_file
      end

      it 'renders the request video link' do
        expect(rendered).to have_link t('hyrax.file_set.show.requestable_content.video_link')
      end
    end
  end

  describe 'audio' do
    context 'when the audio is smaller than the max download size' do
      before do
        render 'hyrax/file_sets/media_display/audio', file_set: small_file
      end

      it 'renders the download audio link' do
        expect(rendered).to have_link t('hyrax.file_set.show.downloadable_content.audio_link')
      end
    end

    context 'when the audio is larger than the max download size' do
      before do
        render 'hyrax/file_sets/media_display/audio', file_set: large_file
      end

      it 'renders the request audio link' do
        expect(rendered).to have_link t('hyrax.file_set.show.requestable_content.audio_link')
      end
    end
  end

  describe 'default' do
    context 'when the file is smaller than the max download size' do
      before do
        render 'hyrax/file_sets/media_display/default', file_set: small_file
      end

      it 'renders the download file document link' do
        expect(rendered).to have_link t('hyrax.file_set.show.downloadable_content.default_link')
      end
    end

    context 'when the file is larger than the max download size' do
      before do
        render 'hyrax/file_sets/media_display/default', file_set: large_file
      end

      it 'renders the request file link' do
        expect(rendered).to have_link t('hyrax.file_set.show.requestable_content.default_link')
      end
    end
  end
end
