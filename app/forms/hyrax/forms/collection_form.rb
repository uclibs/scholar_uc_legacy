# frozen_string_literal: true
module Hyrax
  module Forms
    class CollectionForm
      include HydraEditor::Form

      delegate :id, to: :model

      # TODO: remove this when https://github.com/projecthydra/hydra-editor/pull/115
      # is merged and hydra-editor 3.0.0 is released
      delegate :model_name, to: :model

      self.model_class = ::Collection

      delegate :human_readable_type, :member_ids, to: :model

      self.terms = [:resource_type, :title, :creator, :contributor, :description,
                    :keyword, :rights, :publisher, :date_created, :subject, :language,
                    :representative_id, :thumbnail_id, :identifier, :based_near,
                    :related_url, :visibility]

      self.required_fields = %i(title creator description rights)

      # @return [Hash] All FileSets in the collection, file.to_s is the key, file.id is the value
      def select_files
        Hash[all_files]
      end

      def primary_terms
        [:title,
         :creator,
         :description,
         :rights]
      end

      def secondary_terms
        []
      end

      def self.model_attributes(_)
        attrs = super
        attrs[:title] = Array(attrs[:title]) if attrs[:title]
        attrs[:description] = Array(attrs[:description]) if attrs[:description]
        attrs[:rights] = Array(attrs[:rights]) if attrs[:rights]
        attrs
      end

      def title
        @attributes['title'].first || ''
      end

      def description
        @attributes['description'].first || ''
      end

      def rights
        @attributes['rights'].first || ''
      end

      private

        def all_files
          member_presenters.flat_map(&:file_set_presenters).map { |x| [x.to_s, x.id] }
        end

        def member_presenters
          PresenterFactory.build_presenters(model.member_ids, WorkShowPresenter, nil)
        end
    end
  end
end
