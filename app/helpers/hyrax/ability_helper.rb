# frozen_string_literal: true
require Hyrax::Engine.root.join('app/helpers/hyrax/ability_helper.rb')
module Hyrax
  module AbilityHelper
    private

      # Needed because of bug in CC locales (see Scholar issue #1348)
      def visibility_text(value)
        return t("hyrax.institution_name") if value == 'authenticated'
        t("hyrax.visibility.#{value}.text", default: value)
      end
  end
end
