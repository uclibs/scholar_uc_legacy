# Generated via
#  `rails generate curation_concerns:work Student`

module CurationConcerns
  class StudentsController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior

    self.curation_concern_type = Student
  end
end
