# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work StudentWork`

module Hyrax
  class StudentWorksController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = StudentWork

    include Hyrax::IIIFManifest

    self.show_presenter = StudentWorkPresenter
  end
end
