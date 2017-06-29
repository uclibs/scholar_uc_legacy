# frozen_string_literal: true
module Hyrax
  class DashboardController < ApplicationController
    include Hyrax::DashboardControllerBehavior

    layout 'dashboard'
  end
end
