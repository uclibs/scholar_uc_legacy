# frozen_string_literal: true
module Hyrax
  class DashboardController < ApplicationController
    include Blacklight::Base

    with_themed_layout 'dashboard'
  end
end
