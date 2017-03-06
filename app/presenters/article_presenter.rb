# frozen_string_literal: true
class ArticlePresenter < Sufia::WorkShowPresenter
  delegate :alternate_title, :journal_title, :issn, :time_period, :required_software, :note, :geo_subject, :doi, to: :solr_document
end
