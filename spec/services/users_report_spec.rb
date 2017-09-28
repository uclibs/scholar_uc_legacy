require 'rails_helper'

describe UsersReport do
  describe '#report_location' do
    it 'should be vendor/users_report.csv' do
      expect(UsersReport.report_location).to eq("#{Rails.root}/vendor/users_report.csv")
    end
  end

  describe '#create_report' do
    let(:fake_users) { [ 
      FakeUser.new('id1', 'foo@bar.com', 'Foo Bar', 'Foo', 'Bar'),
      FakeUser.new('id1', 'foo@bar.com', 'Foo Bar', 'Foo', 'Bar'),
      FakeUser.new('id1', 'foo@bar.com', 'Foo Bar', 'Foo', 'Bar'),
      FakeUser.new('id1', 'foo@bar.com', 'Foo Bar', 'Foo', 'Bar')
    ] }

    before(:each) do
      User.stub(:all).and_return(fake_users)

      File.delete(UsersReport.report_location) if File.exist?(UsersReport.report_location)
    end

    it 'should create a report in the report_location' do
      UsersReport.create_report
      expect(File).to exist(UsersReport.report_location) 
    end

    it 'should create a report one line longer than the number of objects reported on' do
      UsersReport.create_report
      expect(
        File.open(UsersReport.report_location).readlines.size
      ).to eq(fake_users.length + 1)
    end

    class FakeUser < Struct.new(:id, :email, :name, :first_name, :last_name)
    end
  end
end
