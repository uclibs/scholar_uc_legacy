# frozen_string_literal: true
require Sufia::Engine.root.join('app/controllers/concerns/sufia/collections_controller_behavior.rb')
module Sufia
  module CollectionsControllerBehavior
    def show
      super
      @permalinks_presenter = PermalinksPresenter.new(main_app.collection_path)
    end
  end
end
