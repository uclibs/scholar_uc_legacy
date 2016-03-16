require 'seed_methods' 

class AddInitialObjects < ActiveRecord::Migration
  rando_pass = Devise.friendly_token.first(8)
  accounts = {'manydeposits@example.com' => 'Many Deposits', 'nodeposits@example.com' => 'No Deposits', 'manager@example.com' => 'Repository Manager', 'delegate@example.com' => 'Student Delegate'} 

  accounts.each do | email, name |
    unless User.where(email: email).exists?
      SeedMethods.new_account(email, name, rando_pass)
      puts "-- Test account created: #{email}, #{rando_pass}"
    end
  end

  accounts.reject{ | email, name | email == 'nodeposits@example.com' }.each do | email, name |
    10.times { |i| SeedMethods.new_image(email, name) }
    10.times { |i| SeedMethods.new_document(email, name) }
    10.times { |i| SeedMethods.new_article(email, name) }
    10.times { |i| SeedMethods.new_dataset(email, name) }
    10.times { |i| SeedMethods.new_genericwork(email, name) }
    10.times { |i| SeedMethods.new_video(email, name) }
  end
end

