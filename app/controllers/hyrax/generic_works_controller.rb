# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work GenericWork`

module Hyrax
  class GenericWorksController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = GenericWork

    include Hyrax::IIIFManifest

    self.show_presenter = GenericWorkPresenter
  end
end
