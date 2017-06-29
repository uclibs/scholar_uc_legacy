# frozen_string_literal: true
require 'rails_helper'

describe CommonObjectsController do
  let(:curation_concern) { create :work }

  describe '#show' do
    context 'with valid work' do
      it 'redirects to the work path' do
        get :show, params: { id: curation_concern.to_param }
        expect(response.status).to eq(302)
      end
    end

    context 'with invalid pid' do
      it 'returns an error' do
        get :show, params: { id: 'foo' }
        expect(response.status).to eq(404)
      end
    end
  end
end
