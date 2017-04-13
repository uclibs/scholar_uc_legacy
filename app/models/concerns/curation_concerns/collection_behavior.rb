# frozen_string_literal: true
require CurationConcerns::Engine.root.join('app/models/concerns/curation_concerns/collection_behavior.rb')
module CurationConcerns
  module CollectionBehavior
    private

      # Field name to look up when locating the size of each file in Solr.
      # Override for your own installation if using something different
      def file_size_field
        Solrizer.solr_name(:file_size, CurationConcerns::FileSetIndexer::STORED_LONG)
      end
  end
end
