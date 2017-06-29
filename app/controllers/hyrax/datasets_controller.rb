# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work Dataset`

module Hyrax
  class DatasetsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = Dataset

    include Hyrax::IIIFManifest

    def new
      super
      flash[:notice] = "If you would like guidance on submitting a dataset, please read the #{view_context.link_to 'Documenting Data', '/documenting_data', target: '_blank'} help page."
    end
    self.show_presenter = DatasetPresenter
  end
end
