require Curate::Engine.root.join('app/controllers/registrations_controller.rb')
class RegistrationsController
SUCCESS_NOTICE = "You have been disconnected from your orcid account."
  def update(&block)
    if current_user.provider == 'shibboleth'
      shibboleth_user_is_updating_their_user_registration(&block)
    elsif current_user.manager?
      manager_is_updating_a_user_registration(&block)
    else
      current_user_is_updating_their_user_registration(&block)
    end
  end

  def disconnect_orcid
    Orcid.disconnect_user_and_orcid_profile(current_user)
    redirect_to catalog_index_path, notice: SUCCESS_NOTICE
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
