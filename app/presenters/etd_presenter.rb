# frozen_string_literal: true
class EtdPresenter < Sufia::WorkShowPresenter
  delegate :alternate_title, :genre, :time_period, :required_software, :note, :degree, :advisor, :geo_subject, :doi, to: :solr_document
end
