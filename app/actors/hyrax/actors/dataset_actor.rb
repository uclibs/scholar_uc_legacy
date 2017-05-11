# frozen_string_literal: true
# Generated via
#  `rails generate hyrax:work Dataset`
module Hyrax
  module Actors
    class DatasetActor < Hyrax::Actors::BaseActor
      private

        def save
          curation_concern.extend(RemotelyIdentifiedByDoi::MintingBehavior)
          curation_concern.apply_doi_assignment_strategy do |*|
            curation_concern.save
          end
        end
    end
  end
end
