# frozen_string_literal: true
class CommonObjectsController < ApplicationController
  def show
    redirect_to polymorphic_path([curation_concern])
  end

  private

    def curation_concern
      @curation_concern ||= ActiveFedora::Base.find(params[:id], cast: true)
    end
end
