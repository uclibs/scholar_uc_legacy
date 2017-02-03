# frozen_string_literal: true
class ImagePresenter < Sufia::WorkShowPresenter
  delegate :alternate_title, :date_photographed, :genre, :time_period, :required_software, :note, :cultural_context, to: :solr_document
end
