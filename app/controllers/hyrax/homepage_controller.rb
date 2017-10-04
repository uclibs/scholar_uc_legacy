# frozen_string_literal: true
class Hyrax::HomepageController < ApplicationController
  include Hyrax::HomepageControllerBehavior

  private

    # store paramater in request
    def store_current_location
      store_location_for(:user, '/')
    end
end
