require Curate::Engine.root.join('app/models/account')
class Account
  def self.omniauth_providers  
    User.omniauth_providers
  end
end
