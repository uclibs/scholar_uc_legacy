# frozen_string_literal: true
require Hyrax::Engine.root.join('app/renderers/hyrax/renderers/faceted_attribute_renderer.rb')
module Hyrax
  module Renderers
    class FacetedAttributeRenderer < AttributeRenderer
      private

        def li_value(value)
          link_to(ERB::Util.h(value), search_path(value).gsub('%26amp%3B', '%26'))
        end
    end
  end
end
