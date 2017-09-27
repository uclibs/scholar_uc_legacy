namespace :manifest do
  desc "Run all manifest reports"
  task :all => [:works, :files, :people, :profiles, :users, :collections, :groups, :linked_resources] do
  end

  desc "Run work manifest reports"
  task :works => :environment do
    WorksReport.create_report
  end

  desc "Run files manifest reports"
  task :files => :environment do
    FilesReport.create_report
  end

  desc "Run people manifest reports"
  task :people => :environment do
    PeopleReport.create_report
  end

  desc "Run profiles manifest reports"
  task :profiles => :environment do
    ProfilesReport.create_report
  end

  desc "Run users manifest reports"
  task :users => :environment do
    UsersReport.create_report
  end

  desc "Run collections manifest reports"
  task :collections => :environment do
    CollectionsReport.create_report
  end

  desc "Run groups manifest reports"
  task :groups => :environment do
    GroupsReport.create_report
  end

  desc "Run linked_resources manifest reports"
  task :linked_resources => :environment do
    LinkedResourcesReport.create_report
  end
end

