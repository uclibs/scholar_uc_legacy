# frozen_string_literal: true
require Sufia::Engine.root.join('app/controllers/sufia/admin/admin_sets_controller.rb')
module Sufia
  class Admin::AdminSetsController
    private

      def create_admin_set
        AdminSetCreateService.new(@admin_set, current_user, selected_workflow).create
      end

      def selected_workflow
        params[:admin_set][:workflow_name]
      end
  end
end
