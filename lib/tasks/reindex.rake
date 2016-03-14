namespace :solr do
  desc "Resolrize the repository objects NOW"
  task :reindexnow => :environment do
    ActiveFedora::Base.reindex_everything
  end
end

