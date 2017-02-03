# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Etd`

module CurationConcerns
  class EtdsController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = Etd
    self.show_presenter = EtdPresenter
  end
end
