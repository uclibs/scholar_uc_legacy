# Generated via
#  `rails generate curation_concerns:work Media`
module CurationConcerns
  class MediaForm < Sufia::Forms::WorkForm
    self.model_class = ::Media
    self.terms += [:resource_type]

  end
end
