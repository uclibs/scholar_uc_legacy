# Generated via
#  `rails generate curation_concerns:work Video`

module CurationConcerns
  class VideosController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior

    self.curation_concern_type = Video
  end
end
