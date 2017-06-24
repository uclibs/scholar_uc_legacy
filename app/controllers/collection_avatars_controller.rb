# frozen_string_literal: true
class CollectionAvatarsController < ApplicationController
  before_action :set_collection_avatar, only: [:show, :edit, :update, :destroy]

  # GET /collection_avatars/1
  # GET /collection_avatars/1.json
  def show; end

  # GET /collection_avatars/new
  def new
    @collection_avatar = CollectionAvatar.new
  end

  # GET /collection_avatars/1/edit
  def edit; end

  # POST /collection_avatars
  # POST /collection_avatars.json
  def create
    @collection_avatar = CollectionAvatar.new(collection_avatar_params)

    respond_to do |format|
      if @collection_avatar.save
        format.html { redirect_to @collection_avatar, notice: 'Collection avatar was successfully created.' }
        format.json { render :show, status: :created, location: @collection_avatar }
      else
        format.html { render template: 'hyrax/collections/new' }
        format.json { render json: @collection_avatar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collection_avatars/1
  # PATCH/PUT /collection_avatars/1.json
  def update
    respond_to do |format|
      if @collection_avatar.update(collection_avatar_params)
        format.html { redirect_to @collection_avatar, notice: 'Collection avatar was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection_avatar }
      else
        format.html { render template: 'hyrax/collections/edit' }
        format.json { render json: @collection_avatar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collection_avatars/1
  # DELETE /collection_avatars/1.json
  def destroy
    @collection_avatar.destroy
    respond_to do |format|
      format.html { redirect_to collection_avatars_url, notice: 'Collection avatar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_collection_avatar
      @collection_avatar = CollectionAvatar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_avatar_params
      params.fetch(:collection_avatar, {})
    end
end
