# frozen_string_literal: true
require "rails_helper"

RSpec.describe PermalinksPresenter do
  let(:path) { "/path/to/page" }
  let(:presenter) { described_class.new(path) }
  Rails.application.config.application_root_url = 'http://my.url'

  describe "permalink" do
    subject { presenter.permalink }
    it { is_expected.to eq '<p>Link to this page: <a href="http://my.url/path/to/page">http://my.url/path/to/page</a></p>' }
  end

  describe "link_message" do
    subject { presenter.link_message }
    it { is_expected.to eq 'Link to this page' }
  end

  describe "link_html" do
    subject { presenter.link_html }
    it { is_expected.to eq '<a href="http://my.url/path/to/page">http://my.url/path/to/page</a>' }
  end

  describe "url" do
    subject { presenter.url }
    it { is_expected.to eq 'http://my.url/path/to/page' }
  end

  context "when a custom message is supplied" do
    let(:message) { "Custom message" }
    let(:presenter) { described_class.new(path, message) }

    describe "link_message" do
      subject { presenter.link_message }
      it { is_expected.to eq 'Custom message' }
    end
  end
end
