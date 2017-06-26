# frozen_string_literal: true
module Hyrax
  class CollectionsController < ApplicationController
    include CollectionsControllerBehavior
    include BreadcrumbsForCollections

    def new
      super
      collection.visibility = "open"
    end
  end
end
