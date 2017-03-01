# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Article`
module CurationConcerns
  class ArticleForm < Sufia::Forms::WorkForm
    self.model_class = ::Article

    self.terms += [:resource_type, :alternate_title, :journal_title, :issn, :time_period, :required_software, :note, :geo_subject]
    self.terms -= [:keyword, :source]
    self.required_fields = [:title, :creator, :description, :rights]

    def secondary_terms
      [:date_created, :alternate_title, :journal_title,
       :issn, :subject, :geo_subject,
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
