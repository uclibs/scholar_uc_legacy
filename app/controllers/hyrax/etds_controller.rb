# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work Etd`

module Hyrax
  class EtdsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = Etd

    include Hyrax::IIIFManifest

    self.show_presenter = EtdPresenter
  end
end
