# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work Document`

module Hyrax
  class DocumentsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = Document

    include Hyrax::IIIFManifest

    self.show_presenter = DocumentPresenter
  end
end
