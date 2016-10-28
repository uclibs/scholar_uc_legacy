# frozen_string_literal: true
require 'rails_helper'

describe StaticController do
  describe '#about' do
    it 'renders the about page' do
      get :about
      expect(response.status).to be == 200
      expect(response).to render_template('static/about')
    end
  end
  describe '#coll_policy' do
    it 'renders the collection policy page' do
      get :coll_policy
      expect(response.status).to be == 200
      expect(response).to render_template('static/coll_policy')
    end
  end
  describe '#format_advice' do
    it 'renders the format advice page' do
      get :format_advice
      expect(response.status).to be == 200
      expect(response).to render_template('static/format_advice')
    end
  end
  describe '#faq' do
    it 'renders the faq advice page' do
      get :faq
      expect(response.status).to be == 200
      expect(response).to render_template('static/faq')
    end
  end
  describe '#distribution_license' do
    it 'renders the distribution_license page' do
      get :distribution_license
      expect(response.status).to be == 200
      expect(response).to render_template('static/distribution_license')
    end
  end
  describe '#documenting_data' do
    it 'renders the documenting_data page' do
      get :documenting_data
      expect(response.status).to be == 200
      expect(response).to render_template('static/documenting_data_help')
    end
  end
  describe '#creators_rights' do
    it 'renders the creators_rights page' do
      get :creators_rights
      expect(response.status).to be == 200
      expect(response).to render_template('static/creators_rights')
    end
  end
end
