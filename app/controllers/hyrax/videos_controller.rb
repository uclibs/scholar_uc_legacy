# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Video`

module Hyrax
  class VideosController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = Video

    include Hyrax::IIIFManifest

    self.show_presenter = VideoPresenter
  end
end
