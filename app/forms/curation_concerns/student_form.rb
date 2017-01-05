# Generated via
#  `rails generate curation_concerns:work Student`
module CurationConcerns
  class StudentForm < Sufia::Forms::WorkForm
    self.model_class = ::Student
    self.terms += [:resource_type]

  end
end
