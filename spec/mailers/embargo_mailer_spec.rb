# frozen_string_literal: true
require 'rails_helper'
require 'rake'

describe EmbargoMailer do
  context "an embargoed work" do
    let(:embargo_date) { Time.zone.today + 30 }
    let(:user) { FactoryGirl.create(:user) }
    let(:work) { FactoryGirl.create(:embargoed_generic_work, user: user, embargo_release_date: embargo_date) }
    before { described_class.deliveries = [] }

    it "sends the EmbargoMailer.notify email" do
      load File.expand_path("../../../lib/tasks/embargo_manager.rake", __FILE__)
      Rake::Task.define_task(:environment)
      work

      Rake::Task['embargo_manager:release'].invoke
      expect(described_class.deliveries.length).to eq(1)
    end
  end

  context 'class methods' do
    describe 'notify should' do
      it 'return a mail object with proper to and from' do
        expect(described_class.notify('user1@example.com', 'my test work', 5).to).to include('user1@example.com')
        expect(described_class.notify('user1@example.com', 'my test work', 5).from).to include('scholar@uc.edu')
      end
    end
  end
end
