# frozen_string_literal: true
require 'rails_helper'

describe Hyrax::Controller do
  let(:resource) { FactoryGirl.create(:user) }
  let(:dummy_class) { DummyClass.new }

  class DummyClass
  end

  before do
    dummy_class.extend(described_class)
    sign_in resource
  end

  describe 'after_sign_in_path_for' do
    context "when the user has not waived the welcome page" do
      before do
        resource.waived_welcome_page = false
      end
      it "redirects the user to the welcome page after sign in" do
        expect(dummy_class.after_sign_in_path_for(resource)).to eq Rails.application.routes.url_helpers.welcome_page_index_path
      end
    end

    context "when the user has waived the welcome page" do
      before do
        resource.waived_welcome_page = true
      end
      it "redirects the user to the welcome page after sign in" do
        expect(dummy_class.after_sign_in_path_for(resource)).to eq dummy_class.landing_page
      end
    end
  end

  describe 'landing_page' do
    it "has a landing_page set to the dashboard" do
      expect(dummy_class.landing_page).to eq Hyrax::Engine.routes.url_helpers.dashboard_index_path
    end
  end
end
