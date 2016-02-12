require 'spec_helper'

describe "curation_concern/generic_files/_media_display.html.erb" do
  before do
    allow(view).to receive(:generic_file).and_return(generic_file)
  end
  context "for an image" do
    let(:generic_file) { double(id: 'abc123', image?: true) }

    it "displays openseadragon" do
      expect(view).to receive(:openseadragon_picture_tag).with('https://localhost/loris/abc123/info.json').and_return("<picture>".html_safe)
      render
      expect(rendered).to match /<picture>/ 

    end
  end
end
