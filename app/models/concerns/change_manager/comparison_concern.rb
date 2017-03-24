module ChangeManager
  module ComparisonConcern
    extend ActiveSupport::Concern

    def is_proxy_change?
      self.change_type == 'added_as_proxy' || self.change_type == 'removed_as_proxy'
    end

    def is_editor_change?
      self.change_type == 'added_as_editor' || self.change_type == 'removed_as_editor'
    end

    def is_embargo?
      self.change_type == 'embargo_set' || self.change_type == 'embargo_lifted'
    end
  end
end
