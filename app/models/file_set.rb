# frozen_string_literal: true
# Generated by curation_concerns:models:install
class FileSet < ActiveFedora::Base
  include ::Hyrax::FileSetBehavior
  include Sufia::FileSetBehavior
end
