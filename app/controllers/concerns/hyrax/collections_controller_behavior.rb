# frozen_string_literal: true
require Sufia::Engine.root.join('app/controllers/concerns/sufia/collections_controller_behavior.rb')
module Sufia
  module CollectionsControllerBehavior
    def create
      super
      create_collection_avatar
    end

    def show
      super
      @collection_avatar = fetch_collection_avatar
      @permalinks_presenter = PermalinksPresenter.new(main_app.collection_path)
    end

    def edit
      super
      @collection_avatar = fetch_collection_avatar
    end

    def update
      super
      if fetch_collection_avatar.nil?
        create_collection_avatar
      else
        update_collection_avatar
      end
    end

    def destroy
      super
      fetch_collection_avatar.destroy! unless fetch_collection_avatar.nil?
    end

    private

      def fetch_collection_avatar
        CollectionAvatar.find_by(collection_id: collection.id)
      end

      def create_collection_avatar
        return if params[:collection][:avatar].nil?
        collection_thumbnail = CollectionAvatar.new(avatar: params[:collection][:avatar], collection_id: @collection.id)
        collection_thumbnail.save!
      rescue ActiveRecord::RecordInvalid => exception
        flash[:alert] = exception.message
        return
      end

      def update_collection_avatar
        return if params[:collection][:avatar].nil?
        collection_thumbnail = fetch_collection_avatar
        collection_thumbnail.avatar = params[:collection][:avatar]
        collection_thumbnail.save!
      rescue ActiveRecord::RecordInvalid => exception
        flash[:alert] = exception.message
        return
      end
  end
end
