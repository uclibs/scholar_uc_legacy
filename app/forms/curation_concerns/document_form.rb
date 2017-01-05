# Generated via
#  `rails generate curation_concerns:work Document`
module CurationConcerns
  class DocumentForm < Sufia::Forms::WorkForm
    self.model_class = ::Document
    self.terms += [:resource_type]

  end
end
