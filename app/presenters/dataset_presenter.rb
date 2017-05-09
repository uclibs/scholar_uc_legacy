# frozen_string_literal: true
class DatasetPresenter < Sufia::WorkShowPresenter
  delegate :alt_description, :alt_date_created, :college, :department, :alternate_title, :genre, :time_period, :required_software, :note, :geo_subject, :doi, to: :solr_document
end
