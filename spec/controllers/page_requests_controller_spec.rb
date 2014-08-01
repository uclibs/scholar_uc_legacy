require 'spec_helper'

describe PageRequestsController do
  describe '#view_terms' do
    it 'renders a terms and conditions page' do
        get :view_terms
        response.status.should == 200
        expect(response).to render_template('terms')
    end
  end

  describe '#view_about' do
    it 'renders an about this application page' do
        get :view_about
        response.status.should == 200
        expect(response).to render_template('about')
    end
  end

  describe '#view_presentation' do
    it 'renders the presentation page' do
        get :view_presentation
        response.status.should == 200
        expect(response).to render_template('presentation')
    end
  end

end

