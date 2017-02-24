# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work StudentWork`
module CurationConcerns
  class StudentWorkForm < Sufia::Forms::WorkForm
    self.model_class = ::StudentWork
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
