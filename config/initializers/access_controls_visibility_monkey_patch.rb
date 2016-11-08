# frozen_string_literal: true
module Hydra::AccessControls
  module Visibility
    extend ActiveSupport::Concern

    def visibility
      if read_groups.include? AccessRight::PERMISSION_TEXT_VALUE_PUBLIC
        AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
      elsif read_groups.include? AccessRight::PERMISSION_TEXT_VALUE_AUTHENTICATED
        AccessRight::VISIBILITY_TEXT_VALUE_AUTHENTICATED
      else
        AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
      end
    end
  end
end
