class FeedEntry < ActiveRecord::Base

# set constants
  SCHOLAR_BLOG = {
    url:   'http://libapps.libraries.uc.edu/scholarblog/',
    title: 'Scholarblog'
    }

  validates_presence_of :name
  validates_presence_of :summary
  validates_presence_of :url
  validates_presence_of :published_at
  validates_presence_of :guid

  def self.update_from_feed(feed_url)
    feed = Feedjira::Feed.fetch_and_parse(feed_url)
    feed.entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          name:         entry.title,
          summary:      entry.summary,
          url:          entry.url,
          published_at: entry.published,
          guid:         entry.id
          )
        puts "New entry: #{entry.url}"
      end
    end
  end
end
