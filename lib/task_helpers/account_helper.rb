# frozen_string_literal: true
module AccountHelper
  def generate_uc_account(attributes)
    unless User.where(email: attributes["email"]).exists?
      attributes = attributes.to_hash
      proxy_emails = attributes.delete("proxy_emails")
      attributes["password"] = (0...16).map { ('a'..'z').to_a[rand(26)] }.join
      new_user = User.create attributes
      new_user.save!
      return true if proxy_emails.nil?
      add_proxy_users(new_user, proxy_emails)
    end
  end

  private

    def add_proxy_users(user, proxy_emails)
      proxy_emails.split("|").each do |email|
        user.can_receive_deposits_from << User.where(email: email).first
      end
      user.save
    end
end
