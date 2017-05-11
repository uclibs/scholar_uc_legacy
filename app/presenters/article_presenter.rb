# frozen_string_literal: true
class ArticlePresenter < Hyrax::WorkShowPresenter
  delegate :alt_description, :alt_date_created, :college, :department, :alternate_title, :journal_title, :issn, :time_period, :required_software, :note, :geo_subject, :doi, to: :solr_document
end
