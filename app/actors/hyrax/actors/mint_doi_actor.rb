# frozen_string_literal: true
module Hyrax
  module Actors
    class MintDoiActor < Hyrax::Actors::AbstractActor
      def create(attributes)
        next_actor.create(attributes)
        apply_doi_assignment_strategy(curation_concern)
      end

      def update(attributes)
        next_actor.update(attributes)
        apply_doi_assignment_strategy(curation_concern)
      end

      private

        def apply_doi_assignment_strategy(curation_concern)
          curation_concern.extend(RemotelyIdentifiedByDoi::MintingBehavior)
          curation_concern.apply_doi_assignment_strategy { curation_concern.save }
        end
    end
  end
end
