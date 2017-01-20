# frozen_string_literal: true
require 'rails_helper'

describe CommonObjectsController do
  let(:curation_concern) { create :work }

  describe '#show' do
    context 'with valid work' do
      it 'redirects to the work path' do
        get :show, id: curation_concern.to_param
        response.status.should == 302
      end
    end

    context 'with invalid pid' do
      it 'returns an error' do
        get :show, id: 'foo'
        response.status.should == 404
      end
    end
  end
end
