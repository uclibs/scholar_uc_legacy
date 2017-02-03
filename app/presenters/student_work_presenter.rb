# frozen_string_literal: true
class StudentWorkPresenter < Sufia::WorkShowPresenter
  delegate :alternate_title, :genre, :time_period, :required_software, :note, :degree, :advisor, :geo_subject, to: :solr_document
end
