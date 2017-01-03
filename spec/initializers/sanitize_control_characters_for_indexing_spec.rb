# frozen_string_literal: true
require 'rails_helper'

describe SanitizeControlCharactersForIndexing do
  it 'will escape control characters on solrize' do
    expect { ActiveFedora::SolrService.add(title_tesim: "a\fb\tc", id: '123') }.not_to raise_error
  end

  context '.sanitize_document' do
    it "preserves tabs, newline, and form feed control characters but replaces others with a blank" do
      expect(described_class.sanitize_document(hello: "w\n\foot")).to eq(hello: "w\n oot")
    end
  end

  context '.sanitize_value' do
    it "preserves tabs, newline, and form feed control characters but replaces others with a blank" do
      given = "a\tb\nc\fd\re"
      expected = "a\tb\nc d\re"
      expect(described_class.sanitize_value(given)).to eq(expected)
    end
  end
end
