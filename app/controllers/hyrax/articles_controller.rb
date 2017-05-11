# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work Article`

module Hyrax
  class ArticlesController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = Article

    include Hyrax::IIIFManifest

    self.show_presenter = ArticlePresenter
  end
end
