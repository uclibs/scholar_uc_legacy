# frozen_string_literal: true
describe CatalogController, type: :controller do
  routes { Rails.application.class.routes }

  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "#index" do
    let(:rocks) do
      GenericWork.new(id: 'rock123', title: ['Rock'], read_groups: ['public'])
    end

    let(:clouds) do
      GenericWork.new(id: 'cloud123', title: ['Cloud'], read_groups: ['public'],
                      contributor: ['frodo'])
    end

    before do
      objects.each { |obj| ActiveFedora::SolrService.add(obj.to_solr) }
      ActiveFedora::SolrService.commit
    end

    describe 'full-text search', skip: 'Will GenericWorks have a full_text search?' do
      let(:objects) { [rocks, clouds] }
      it 'finds matching records' do
        get :index, params: { q: 'full_textfull_text' }
        expect(response).to be_success
        expect(response).to render_template('catalog/index')
        expect(assigns(:document_list).map(&:id)).to contain_exactly(clouds.id)
      end
    end
  end # describe "#index"
end
