# Generated via
#  `rails generate curation_concerns:work Document`

module CurationConcerns
  class DocumentsController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior

    self.curation_concern_type = Document
  end
end