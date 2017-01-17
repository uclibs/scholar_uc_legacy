# frozen_string_literal: true
require Sufia::Engine.root.join('app/controllers/concerns/sufia/users_controller_behavior.rb')
module Sufia::UsersControllerBehavior
  def show
    @presenter = Sufia::UserProfilePresenter.new(@user, current_ability)
    @permalinks_presenter = PermalinksPresenter.new(sufia.profile_path)
  end
end
