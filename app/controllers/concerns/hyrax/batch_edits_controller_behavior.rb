# frozen_string_literal: true
require Hyrax::Engine.root.join('app/controllers/concerns/hyrax/batch_edits_controller_behavior.rb')
module Hyrax
  module BatchEditsControllerBehavior
    def update_document(obj)
      obj.attributes = if work_params["rights"].nil?
                         work_params
                       else
                         work_params.merge("rights" => [work_params["rights"]])
                       end
      obj.date_modified = Time.current.ctime
      obj.visibility = params[:visibility]
    end
  end
end
