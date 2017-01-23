# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Dataset`

module CurationConcerns
  class DatasetsController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = Dataset
  end
end
