class Scholar::TitleIndexingService <  Sufia::TitleIndexingService
  include LinkUtils

  def generate_solr_document
    byebug
    super.tap do |solr_doc|
      Solrizer.insert_field(solr_doc, 'sortable_title', object.title.first.downcase, :stored_sortable) if object.title && !object.title.empty?
    end
  end
end
