require 'spec_helper'
require 'rake'

describe EmbargoMailer do
	context "an embargoed work" do
	  let(:embargo_date) { Date.today + 30 }
  	let(:work) { FactoryGirl.create(:generic_work_with_one_file, depositor: 'test@example.com', title: 'test', visibility: Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_EMBARGO, embargo_release_date: embargo_date) }
	  it "should send the EmbargoMailer.notify email" do
	    load File.expand_path("../../../lib/tasks/embargo_manager.rake", __FILE__)
	    Rake::Task.define_task(:environment)
	    work

	    EmbargoMailer.should receive(:notify).with(["test@example.com"],["test"],30)
	    Rake::Task['embargomanager:release'].invoke
	  end
	end
end
