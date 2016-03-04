require 'spec_helper'

describe "page_requests/documenting_data_help.html.erb" do

	it "has a valid route, and renders properly" do
		visit '/data_help_request'
		expect(page).to have_content("Documenting Data")
		expect(page).to have_link("Digital Curation Centre How-to Guides & Checklists")
	end	
end