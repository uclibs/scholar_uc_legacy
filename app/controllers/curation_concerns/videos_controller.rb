# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Video`

module CurationConcerns
  class VideosController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = Video

    include Sufia::IIIFManifest

    self.show_presenter = VideoPresenter
  end
end
