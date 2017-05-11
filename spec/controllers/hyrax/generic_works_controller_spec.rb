# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work GenericWork`
require 'rails_helper'

describe Hyrax::GenericWorksController do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "#new" do
    before { get :new }
    it "is successful" do
      expect(response).to be_successful
      expect(response).to render_template("layouts/curation_concerns/1_column")
      expect(assigns[:curation_concern]).to be_kind_of GenericWork
    end

    it "defaults to public visibility" do
      expect(assigns[:curation_concern].read_groups).to eq ['public']
    end
  end
end
