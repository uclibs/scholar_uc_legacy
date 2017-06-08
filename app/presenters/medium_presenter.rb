# frozen_string_literal: true
class MediumPresenter < Hyrax::WorkShowPresenter
  delegate :alt_description, :alt_date_created, :college, :department, :alternate_title, :time_period, :required_software, :note, :doi, to: :solr_document
end
