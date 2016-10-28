require 'spec_helper'
require 'rake'

describe "Rake tasks" do
  describe "account:generate" do

    before do
      load File.expand_path("../../../../lib/tasks/account.rake", __FILE__)
      Rake::Task.define_task(:environment)
    end

    it 'creates a user' do
      Rake::Task["account:generate"].invoke('bearcat1','Bear','Cat')
      user = User.where(email: 'bearcat1@ucmail.uc.edu', first_name: 'Bear', last_name: 'Cat').first
      expect(user).to be_present
      expect(user.person).to be_present
      expect(user.profile).to be_present
    end

  end
end

