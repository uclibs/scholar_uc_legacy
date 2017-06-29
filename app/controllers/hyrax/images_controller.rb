# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work Image`

module Hyrax
  class ImagesController < ApplicationController
    # Adds Hyrax behaviors to the controller.

    include Hyrax::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = Image

    include Hyrax::IIIFManifest

    self.show_presenter = ImagePresenter
  end
end
