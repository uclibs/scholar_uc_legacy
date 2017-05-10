# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work Video`
module Hyrax
  module Actors
    class VideoActor < Hyrax::Actors::BaseActor
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
