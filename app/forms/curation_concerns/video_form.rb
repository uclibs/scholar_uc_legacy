# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Video`
module CurationConcerns
  class VideoForm < Sufia::Forms::WorkForm
    self.model_class = ::Video
    self.terms += [:resource_type]
  end
end
