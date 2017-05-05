# frozen_string_literal: true
class EtdPresenter < Sufia::WorkShowPresenter
  delegate :alt_description, :alt_date_created, :college, :department, :alternate_title, :time_period, :required_software, :note, :degree, :advisor, :committee_member, :geo_subject, :doi, :etd_publisher, to: :solr_document
end
