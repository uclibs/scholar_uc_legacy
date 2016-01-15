require 'spec_helper'

describe FeedEntry do
  it "has a valid FeedEntry factory" do
    expect(build(:feed_entry)).to be_valid
  end

  it "reponds to name" do
    expect(build(:feed_entry)).to respond_to(:name)
  end

  it "reponds to url" do
    expect(build(:feed_entry)).to respond_to(:url)
  end

  it "reponds to summary" do
    expect(build(:feed_entry)).to respond_to(:summary)
  end

  it "reponds to published_at" do
    expect(build(:feed_entry)).to respond_to(:published_at)
  end

  it "reponds to guid" do
    expect(build(:feed_entry)).to respond_to(:guid)
  end
end
