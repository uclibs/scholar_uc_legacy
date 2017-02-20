# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Document`
module CurationConcerns
  class DocumentForm < Sufia::Forms::WorkForm
    self.model_class = ::Document
    self.terms += [:resource_type]

    def self.multiple?(field)
      if field.to_sym == :rights
        false
      else
        super
      end
    end
  end
end
