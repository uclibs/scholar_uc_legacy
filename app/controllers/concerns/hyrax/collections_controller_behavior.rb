# frozen_string_literal: true
require Hyrax::Engine.root.join('app/controllers/concerns/hyrax/collections_controller_behavior.rb')
module Hyrax
  module CollectionsControllerBehavior
    def create
      @collection.apply_depositor_metadata(current_user.user_key)
      add_members_to_collection unless batch.empty?
      if @collection.save
        after_create
      else
        after_create_error
      end
      create_collection_avatar
    end

    def show
      presenter
      query_collection_members
      @collection_avatar = fetch_collection_avatar
      @permalinks_presenter = PermalinksPresenter.new(collection_path(locale: nil))
    end

    def edit
      query_collection_members
      # this is used to populate the "add to a collection" action for the members
      @user_collections = find_collections_for_form
      @collection_avatar = fetch_collection_avatar
      form
    end

    def index
      # run the solr query to find the collections
      query = list_search_builder.with(params).query
      @response = repository.search(query)
      @document_list = @response.documents
    end

    def update
      process_member_changes
      if @collection.update(collection_params.except(:members))
        after_update
      else
        after_update_error
      end
      if fetch_collection_avatar.nil?
        create_collection_avatar
      else
        update_collection_avatar
      end
    end

    def destroy
      if @collection.destroy
        after_destroy(params[:id])
      else
        after_destroy_error(params[:id])
      end
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
