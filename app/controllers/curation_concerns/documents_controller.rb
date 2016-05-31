# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Document`

module CurationConcerns
  class DocumentsController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior
    include Scholar::WorksControllerBehavior
    include Sufia::IIIFManifest

    self.curation_concern_type = Document
  end
end
