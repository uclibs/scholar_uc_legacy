# frozen_string_literal: true
module Sufia::Forms
  class CollectionForm < CurationConcerns::Forms::CollectionEditForm
    delegate :id, to: :model

    # TODO: remove this when https://github.com/projecthydra/hydra-editor/pull/115
    # is merged and hydra-editor 3.0.0 is released
    delegate :model_name, to: :model

    self.required_fields = %i(title creator description rights)

    def primary_terms
      [:title,
       :creator,
       :description,
       :rights]
    end

    def secondary_terms
      []
    end

    def self.multiple?(field)
      if %i(title description rights).include? field.to_sym
        false
      else
        super
      end
    end

    def self.model_attributes(_)
      attrs = super
      attrs[:title] = Array(attrs[:title]) if attrs[:title]
      attrs[:description] = Array(attrs[:description]) if attrs[:description]
      attrs[:rights] = Array(attrs[:rights]) if attrs[:rights]
      attrs
    end

    def title
      super.first || ""
    end

    def description
      super.first || ""
    end

    def rights
      super.first || ""
    end
  end
end
