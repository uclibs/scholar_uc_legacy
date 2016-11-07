require "#{Rails.root}/lib/task_helpers/account_helper"
include AccountHelper

namespace :account do
  task :generate, [:sixplus2, :first_name, :last_name] => [:environment] do |t, args|
    if args[:sixplus2].to_s.present?
    if generate_uc_account(args[:sixplus2].to_s, args[:first_name].to_s, args[:last_name].to_s) 
      puts "Account generated for #{args[:first_name].to_s} #{args[:last_name].to_s} (#{args[:sixplus2].to_s}@ucmail.uc.edu)" 
    else
      puts "Account could not be generated. A user with email #{args[:sixplus2].to_s}@ucmail.uc.edu may already exist." 
    end
    else
      puts "Usage:   rake account:generate['sixplus2','Firstname','Lastname'] (no spaces between the parameters)"
      puts "Example: rake account:generate['jonestn','Ted','Jones']"
    end
  end
end

