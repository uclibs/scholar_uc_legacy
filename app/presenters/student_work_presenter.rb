# frozen_string_literal: true
class StudentWorkPresenter < Hyrax::WorkShowPresenter
  delegate :alt_description, :alt_date_created, :college, :department, :alternate_title, :genre, :time_period, :required_software, :note, :degree, :advisor, :geo_subject, :doi, to: :solr_document
end
