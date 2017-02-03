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

    def new
      super
      flash[:notice] = "If you would like guidance on submitting a dataset, please read the #{view_context.link_to 'Documenting Data', '/documenting_data', target: '_blank'} help page."
    end
    self.show_presenter = DatasetPresenter
  end
end
