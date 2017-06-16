# frozen_string_literal: true
class ImagePresenter < Hyrax::WorkShowPresenter
  delegate :alt_description, :alt_date_created, :college, :department, :alternate_title, :date_photographed, :genre, :time_period, :required_software, :note, :geo_subject, :cultural_context, :doi, to: :solr_document
end
