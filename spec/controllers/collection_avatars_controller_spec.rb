# frozen_string_literal: true

describe CollectionAvatarsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:collection) do
    create(:public_collection, title: ["My collection"],
                               description: ["My incredibly detailed description of the collection"],
                               user: user)
  end

  before do
    sign_in user
  end

  describe "#new" do
    let(:collection_demo) do
      CollectionAvatar.new('id' => '2')
    end

    it "returns a CollectionAvatar object" do
      collection_demo.should be_an_instance_of CollectionAvatar
    end
  end

  describe "#create" do
    it "sets an avatar" do
      post :create, format: :html
      expect(response).to redirect_to('http://test.host/collection_avatars/1')
      expect(flash[:notice]).to include("Collection avatar was successfully created.")
    end

    context "when the save fails" do
      before do
        allow_any_instance_of(CollectionAvatar).to receive(:save).and_return(false)
      end

      it "does not set an avatar" do
        post :create, format: :html
        expect(response).to render_template('collections/new')
      end
    end
  end

  describe "#update" do
    let(:collection_demo) do
      CollectionAvatar.new('id' => '2')
    end

    it "sets an avatar with save" do
      collection_demo.save!
      put :update, id: collection_demo.id
      expect(response).to redirect_to('http://test.host/collection_avatars/2')
      expect(flash[:notice]).to include("Collection avatar was successfully updated.")
    end

    context "when the update fails" do
      before do
        allow_any_instance_of(CollectionAvatar).to receive(:update).and_return(false)
      end

      it "does not set an avatar" do
        collection_demo.save!
        put :update, id: collection_demo.id
        expect(response).to render_template('collections/edit')
      end
    end
  end

  describe "#destroy" do
    let(:collection_demo) do
      @collection_demo = CollectionAvatar.new('id' => '1')
    end
    it "destroys an avatar" do
      collection_demo.save!
      delete :destroy, id: collection_demo.id
      expect(response).to redirect_to(collection_avatars_url)
      expect(flash[:notice]).to include("Collection avatar was successfully destroyed.")
    end
  end
end
