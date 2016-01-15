namespace :rss_feed do
  desc "Update blog feed"
  task:update_feed => :environment do
    FeedEntry.update_from_feed("http://libapps.libraries.uc.edu/scholarblog/feed")
  end
end
  
