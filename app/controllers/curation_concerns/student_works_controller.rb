# Generated via
#  `rails generate curation_concerns:work StudentWork`

module CurationConcerns
  class StudentWorksController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior

    self.curation_concern_type = StudentWork
  end
end
