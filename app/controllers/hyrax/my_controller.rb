# frozen_string_literal: true
class Hyrax::MyController < ApplicationController
  include Hyrax::MyControllerBehavior

  layout 'dashboard'
end
