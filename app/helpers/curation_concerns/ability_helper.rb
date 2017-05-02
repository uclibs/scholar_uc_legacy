# frozen_string_literal: true
require CurationConcerns::Engine.root.join('app/helpers/curation_concerns/ability_helper.rb')
module CurationConcerns
  module AbilityHelper
    private

      # Needed because of bug in CC locales (see Scholar issue #1348)
      def visibility_text(value)
        return t("sufia.institution_name") if value == 'authenticated'
        t("curation_concerns.visibility.#{value}.text", default: value)
      end
  end
end
