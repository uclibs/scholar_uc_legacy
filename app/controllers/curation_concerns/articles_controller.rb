# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Article`

module CurationConcerns
  class ArticlesController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior
    include Scholar::WorksControllerBehavior

    self.curation_concern_type = Article
    self.show_presenter = ArticlePresenter
  end
end
