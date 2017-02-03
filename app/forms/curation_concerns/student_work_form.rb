# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work StudentWork`
module CurationConcerns
  class StudentWorkForm < Sufia::Forms::WorkForm
    self.model_class = ::StudentWork

    self.terms += [:resource_type, :alternate_title, :genre, :time_period, :required_software, :note, :degree, :advisor, :geo_subject]
    self.terms -= [:keyword, :source, :contributor]
    self.required_fields = [:title, :creator, :description, :advisor, :rights]

    def secondary_terms
      [:degree, :date_created, :alternate_title, :genre, :subject, :geo_subject,
       :time_period, :language, :bibliographic_citation,
       :required_software, :note]
    end

    def self.multiple?(field)
      if [:title, :description, :rights, :date_created].include? field.to_sym
        false
      else
        super
      end
    end

    def self.model_attributes(_)
      attrs = super
      attrs[:title] = Array(attrs[:title]) if attrs[:title]
      attrs[:description] = Array(attrs[:description]) if attrs[:description]
      attrs
    end

    def title
      super.first || ""
    end

    def description
      super.first || ""
    end
  end
end
