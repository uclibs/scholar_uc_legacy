# frozen_string_literal: true
require Hyrax::Engine.root.join('app/helpers/hyrax/hyrax_helper_behavior.rb')
module Hyrax
  module HyraxHelperBehavior
    # Uses Rails auto_link to add links to fields
    #
    # @param field [String,Hash] string to format and escape, or a hash as per helper_method
    # @option field [SolrDocument] :document
    # @option field [String] :field name of the solr field
    # @option field [Blacklight::Configuration::IndexField, Blacklight::Configuration::ShowField] :config
    # @option field [Array] :value array of values for the field
    # @param show_link [Boolean]
    # @return [ActiveSupport::SafeBuffer]
    # @todo stop being a helper_method, start being part of the Blacklight render stack?
    def iconify_auto_link(field, show_link = true)
      if field.is_a? Hash
        options = field[:config].separator_options || {}
        text = field[:value].to_sentence(options)
      else
        text = field
      end
      # this block is only executed when a link is inserted;
      # if we pass text containing no links, it just returns text.
      auto_link(html_escape(text)) do |value|
        if show_link
          "<span class='glyphicon glyphicon-new-window'></span>#{('&nbsp;' + value)}"
        else
          %(<span class="glyphicon glyphicon-new-window" aria-hidden="true"></span>
            <span class="sr-only">#{value}</span>)
        end
      end
    end
  end
end
