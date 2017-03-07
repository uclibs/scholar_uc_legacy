# frozen_string_literal: true
require 'rails_helper'

describe 'User siginin', type: :feature do
  context 'when visiting login page' do
    before do
      visit user_session_path
    end

    it "shows forgot/reset pass link" do
      expect(page).to have_content('Reset/Forgot your password')
    end

    it "does not show orcid signin link" do
      expect(page).not_to have_content('Orcid')
    end
  end
end
