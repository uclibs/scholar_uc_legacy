# frozen_string_literal: true
require "#{Rails.root}/lib/task_helpers/account_helper"
require 'csv'
include AccountHelper

# To use: rake account:generate["your_file_path_here"]
namespace :account do
  task :generate, [:file_path] => [:environment] do |_t, args|
    if args[:file_path].nil?
      puts "Usage:   rake account:generate['your_file_path_here']"
      puts "Example: rake account:generate['my_csv.txt']"
    else
      file = CSV.read(args[:file_path], headers: true, col_sep: "\t", quote_char: "\x00")
      file.each do |user|
        if generate_uc_account(user)
          puts "Account generated for #{user['first_name']} #{user['last_name']} (#{user['email']})"
        else
          puts "Account could not be generated. A user with email #{user['email']} may already exist."
        end
      end
    end
  end
end
