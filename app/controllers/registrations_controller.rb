require Curate::Engine.root.join('app/controllers/registrations_controller.rb')
class RegistrationsController

  def update(&block)
    if current_user.provider == "shibboleth"
      shibboleth_user_is_updating_their_user_registration(&block)
    elsif current_user.manager?
      manager_is_updating_a_user_registration(&block)
    else
      current_user_is_updating_their_user_registration(&block)
    end
  end

  protected

  def shibboleth_user_is_updating_their_user_registration(&block)
    user = User.find(params[:user][:id])
    self.resource = resource_class.to_adapter.get!(user)
    scrub_password_parameters_for_manager!
    update_status = resource.update_without_password(account_update_params)
    handle_update_response(update_status: update_status, skip_signin: false, &block)
  end

end
