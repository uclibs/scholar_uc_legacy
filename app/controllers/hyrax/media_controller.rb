# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work Medium`

module Hyrax
  class MediaController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = Medium

    include Hyrax::IIIFManifest

    self.show_presenter = MediumPresenter
  end
end
