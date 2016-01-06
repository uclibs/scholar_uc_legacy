require Curate::Engine.root.join('app/controllers/sessions_controller.rb')
class SessionsController

  def create
    cookies[:login_type] = "local"
    super
  end

end
