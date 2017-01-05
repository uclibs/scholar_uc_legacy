# Generated via
#  `rails generate curation_concerns:work Media`

module CurationConcerns
  class MediaController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior

    self.curation_concern_type = Media
  end
end
