# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Work`

module CurationConcerns
  class WorksController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior

    self.curation_concern_type = Work

    # set default work visibility to public
    def new
      super
      curation_concern.read_groups = ["public"]
    end
  end
end
