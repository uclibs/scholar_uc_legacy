# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Dataset`
require 'rails_helper'

RSpec.describe CurationConcerns::DatasetsController do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  describe '#new' do
    it "sets flash message with help text" do
      get :new
      expect(flash[:notice]).to match('If you would like guidance on submitting a dataset, please read the <a target=\"_blank\" href=\"/documenting_data\">Documenting Data</a> help page.')
    end
  end
end
