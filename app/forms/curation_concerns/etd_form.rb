# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Etd`
module CurationConcerns
  class EtdForm < Sufia::Forms::WorkForm
    self.model_class = ::Etd
    self.terms += [:resource_type]
  end
end
