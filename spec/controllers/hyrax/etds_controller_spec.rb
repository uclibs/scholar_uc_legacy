# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work Etd`
require 'rails_helper'

describe Hyrax::EtdsController do
  let(:user) { create(:user) }
  before do
    allow_any_instance_of(Ability).to receive(:user_is_etd_manager).and_return(true)
    sign_in user
  end

  describe "#new" do
    before { get :new }
    it "is successful" do
      expect(response).to be_successful
      expect(response).to render_template("layouts/hyrax/1_column")
      expect(assigns[:curation_concern]).to be_kind_of Etd
    end

    it "defaults to public visibility" do
      expect(assigns[:curation_concern].read_groups).to eq ['public']
    end
  end
end
