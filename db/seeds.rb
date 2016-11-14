# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

class AddInitialObjects < ActiveRecord::Migration

  def self.create_admin_role(id)
    admin = Role.create(name: "admin")
    admin.users << User.find(id)
    admin.save
  end

  def self.create_admin_account
    rando_pass = Devise.friendly_token.first(8)
    user = User.create email: 'admin@example.com', password: rando_pass
    puts "\n\n\t\t*** ADMIN USER PASS: #{rando_pass} ***\n\n"
    user.save
    user.id
  end

  create_admin_role(create_admin_account)

end
