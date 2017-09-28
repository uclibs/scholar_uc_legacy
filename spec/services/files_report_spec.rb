require 'rails_helper'

describe FilesReport do
  describe '#report_location' do
    it 'should be vendor/files_report.csv' do
      expect(FilesReport.report_location).to eq("#{Rails.root}/vendor/files_report.csv")
    end
  end

  describe '#create_report' do
    let(:fake_files) { [ 
      FakeFile.new('id', 'title', 'label', 'file.pdf', 'foo@bar.org', 'foo@bar.org', ['foo@bar.org', 'foo@bar.org']),
      FakeFile.new('id', 'title', 'label', 'file.pdf', 'foo@bar.org', 'foo@bar.org', ['']),
      FakeFile.new('id', 'title', 'label', 'file.pdf', 'foo@bar.org', 'foo@bar.org', ['foo@bar.org']),
      FakeFile.new('id', 'title', 'label', 'file.pdf', 'foo@bar.org', 'foo@bar.org', ['foo@bar.org', 'foo@bar.org']),
    ] }

    before(:each) do
      FileSet.stub(:all).and_return(fake_files)

      File.delete(FilesReport.report_location) if File.exist?(FilesReport.report_location)
    end

    it 'should create a report in the report_location' do
      FilesReport.create_report
      expect(File).to exist(FilesReport.report_location) 
    end

    it 'should create a report one line longer than the number of objects reported on' do
      FilesReport.create_report
      expect(
        File.open(FilesReport.report_location).readlines.size
      ).to eq(fake_files.length + 1)
    end

    class FakeFile < Struct.new(:id, :title, :label, :filename, :creator, :depositor, :edit_users)
    end
  end
end
