# frozen_string_literal: true
require Hyrax::Engine.root.join('app/services/hyrax/user_stat_importer.rb')
module Hyrax
  class UserStatImporter
    require 'legato'
    require 'hyrax/pageview'
    require 'hyrax/download'
  end
end
