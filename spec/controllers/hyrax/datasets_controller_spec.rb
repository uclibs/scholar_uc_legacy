# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work Dataset`
require 'rails_helper'

RSpec.describe Hyrax::DatasetsController do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  describe "#new" do
    before { get :new }
    it "is successful" do
      expect(response).to be_successful
      expect(response).to render_template("layouts/hyrax/1_column")
      expect(assigns[:curation_concern]).to be_kind_of Dataset
    end

    it "defaults to public visibility" do
      expect(assigns[:curation_concern].read_groups).to eq ['public']
    end

    it "sets flash message with help text" do
      expect(flash[:notice]).to match('If you would like guidance on submitting a dataset, please read the <a target=\"_blank\" href=\"/documenting_data\">Documenting Data</a> help page.')
    end
  end
end
