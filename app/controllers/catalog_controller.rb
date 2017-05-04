# frozen_string_literal: true
class CatalogController < ApplicationController
  include Hydra::Catalog
  include Hydra::Controller::ControllerBehavior
  include Sufia::Catalog

  # These before_filters apply the hydra access controls
  before_action :enforce_show_permissions, only: :show
  skip_before_action :default_html_head

  def self.uploaded_field
    solr_name('system_create', :stored_sortable, type: :date)
  end

  def self.title_field
    solr_name('sort_title', :stored_sortable, type: :string)
  end

  def self.modified_field
    solr_name('system_modified', :stored_sortable, type: :date)
  end

  def self.search_terms
    "title_tesim description_tesim keyword_tesim creator_tesim rights_tesim " \
    "publisher_tesim date_created_tesim subject_tesim language_tesim alternate_title_tesim " \
    "geo_subject_tesim degree_tesim advisor_tesim committee_member_tesim genre_tesim " \
    "time_period_tesim required_software_tesim note_tesim college_tesim department_tesim " \
    "advisor_tesim related_url_tesim source_tesim journal_title_tesim issn_tesim "
  end

  configure_blacklight do |config|
    config.view.gallery.partials = [:index_header, :index]
    config.view.masonry.partials = [:index]
    config.view.slideshow.partials = [:index]

    config.show.tile_source_field = :content_metadata_image_iiif_info_ssm
    config.show.partials.insert(1, :openseadragon)

    config.search_builder_class = Sufia::SearchBuilder

    # Show gallery view
    config.view.gallery.partials = [:index_header, :index]
    config.view.slideshow.partials = [:index]

    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = {
      qt: "search",
      rows: 10,
      qf: search_terms
    }

    # solr field configuration for document/show views
    config.index.title_field = solr_name("title", :stored_searchable)
    config.index.display_type_field = solr_name("has_model", :symbol)
    config.index.thumbnail_field = 'thumbnail_path_ss'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    config.add_facet_field solr_name("human_readable_type", :facetable), label: "Type of Work", limit: 5
    config.add_facet_field solr_name("creator", :facetable), label: "Creator", limit: 5
    config.add_facet_field solr_name("subject", :facetable), label: "Subject", limit: 5
    config.add_facet_field solr_name("college", :facetable), label: "College", limit: 5
    config.add_facet_field solr_name("department", :facetable), label: "Department", limit: 5
    config.add_facet_field solr_name("language", :facetable), label: "Language", limit: 5
    config.add_facet_field solr_name("publisher", :facetable), label: "Publisher", limit: 5
    config.add_facet_field solr_name("date_created", :facetable), label: "Date Created", limit: 5

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field solr_name("has_model", :symbol), label: "Type"
    config.add_index_field solr_name("title", :stored_searchable), label: "Title", itemprop: 'name', if: false
    config.add_index_field solr_name("description", :stored_searchable), label: "Description", itemprop: 'description', helper_method: :iconify_auto_link
    config.add_index_field solr_name("creator", :stored_searchable), label: "Creator", itemprop: 'creator', link_to_search: solr_name("creator", :facetable)
    config.add_index_field solr_name("contributor", :stored_searchable), label: "Contributor", itemprop: 'contributor', link_to_search: solr_name("contributor", :facetable)
    config.add_index_field solr_name("proxy_depositor", :symbol), label: "Depositor", helper_method: :link_to_profile
    config.add_index_field solr_name("depositor"), label: "Submitter", helper_method: :link_to_profile
    config.add_index_field solr_name("publisher", :stored_searchable), label: "Publisher", itemprop: 'publisher', link_to_search: solr_name("publisher", :facetable)
    config.add_index_field solr_name("geo_subject", :stored_searchable), label: "Geographic Subject", itemprop: 'contentLocation', link_to_search: solr_name("based_near", :facetable)
    config.add_index_field solr_name("language", :stored_searchable), label: "Language", itemprop: 'inLanguage', link_to_search: solr_name("language", :facetable)
    config.add_index_field solr_name("date_uploaded", :stored_sortable, type: :date), label: "Date Uploaded", itemprop: 'datePublished'
    config.add_index_field solr_name("date_modified", :stored_sortable, type: :date), label: "Date Modified", itemprop: 'dateModified'
    config.add_index_field solr_name("date_created", :stored_searchable), label: "Date Created", itemprop: 'dateCreated'
    config.add_index_field solr_name("rights", :stored_searchable), label: "Rights", helper_method: :rights_statement_links
    config.add_index_field solr_name("resource_type", :stored_searchable), label: "Resource Type", link_to_search: solr_name("resource_type", :facetable)
    config.add_index_field solr_name("file_format", :stored_searchable), label: "File Format", link_to_search: solr_name("file_format", :facetable)
    config.add_index_field solr_name("identifier", :stored_searchable), label: "Identifier", helper_method: :index_field_link, field_name: 'identifier'
    config.add_index_field solr_name("journal_title", :stored_searchable), label: "Journal Title"
    config.add_index_field solr_name("issn", :stored_searchable), label: "ISSN"
    config.add_index_field solr_name("time_period", :stored_searchable), label: "Time Period"
    config.add_index_field solr_name("required_software", :stored_searchable), label: "Required Software"
    config.add_index_field solr_name("note", :stored_searchable), label: "Note"
    config.add_index_field solr_name("genre", :stored_searchable), label: "Genre"
    config.add_index_field solr_name("degree", :stored_searchable), label: "Degree"
    config.add_index_field solr_name("advisor", :stored_searchable), label: "Advisor"
    config.add_index_field solr_name("committee_member", :stored_searchable), label: "Committee Members"

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    config.add_show_field solr_name("title", :stored_searchable), label: "Title"
    config.add_show_field solr_name("description", :stored_searchable), label: "Description"
    config.add_show_field solr_name("subject", :stored_searchable), label: "Subject"
    config.add_show_field solr_name("creator", :stored_searchable), label: "Creator"
    config.add_show_field solr_name("college", :stored_searchable), label: "College"
    config.add_show_field solr_name("department", :stored_searchable), label: "Program or Department"
    config.add_show_field solr_name("contributor", :stored_searchable), label: "Contributor"
    config.add_show_field solr_name("publisher", :stored_searchable), label: "Publisher"
    config.add_show_field solr_name("geo_subject", :stored_searchable), label: "Geographic Subject"
    config.add_show_field solr_name("language", :stored_searchable), label: "Language"
    config.add_show_field solr_name("date_uploaded", :stored_searchable), label: "Date Uploaded"
    config.add_show_field solr_name("date_modified", :stored_searchable), label: "Date Modified"
    config.add_show_field solr_name("date_created", :stored_searchable), label: "Date Created"
    config.add_show_field solr_name("rights", :stored_searchable), label: "Rights"
    config.add_show_field solr_name("resource_type", :stored_searchable), label: "Resource Type"
    config.add_show_field solr_name("format", :stored_searchable), label: "File Format"
    config.add_show_field solr_name("identifier", :stored_searchable), label: "Identifier"
    config.add_show_field solr_name("alternate_title", :stored_searchable), label: "Alternate Title"
    config.add_show_field solr_name("journal_title", :stored_searchable), label: "Journal Title"
    config.add_show_field solr_name("issn", :stored_searchable), label: "ISSN"
    config.add_show_field solr_name("time_period", :stored_searchable), label: "Time Period"
    config.add_show_field solr_name("required_software", :stored_searchable), label: "Required Software"
    config.add_show_field solr_name("note", :stored_searchable), label: "Note"
    config.add_show_field solr_name("degree", :stored_searchable), label: "Degree"
    config.add_show_field solr_name("advisor", :stored_searchable), label: "Advisor"
    config.add_show_field solr_name("committee_member", :stored_searchable), label: "Committee Member"

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.
    #
    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.
    config.add_search_field('all_fields', label: 'All Fields', include_in_advanced_search: false) do |field|
      all_names = config.show_fields.values.map(&:field).join(" ")
      title_name = solr_name("title", :stored_searchable)
      field.solr_parameters = {
        qf: "#{all_names} file_format_tesim all_text_timv",
        pf: title_name.to_s
      }
    end

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.
    # creator, title, description, publisher, date_created,
    # subject, language, resource_type, format, identifier, based_near,
    config.add_search_field('contributor') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params.

      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      solr_name = solr_name("contributor", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('creator') do |field|
      solr_name = solr_name("creator", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('title') do |field|
      solr_name = solr_name("title", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('description') do |field|
      field.label = "Abstract or Summary"
      solr_name = solr_name("description", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('publisher') do |field|
      solr_name = solr_name("publisher", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('date_created') do |field|
      solr_name = solr_name("date_created", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('subject') do |field|
      solr_name = solr_name("subject", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('language') do |field|
      solr_name = solr_name("language", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('resource_type') do |field|
      solr_name = solr_name("resource_type", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('format') do |field|
      field.include_in_advanced_search = false
      solr_name = solr_name("format", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('identifier') do |field|
      field.include_in_advanced_search = false
      solr_name = solr_name("id", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('based_near') do |field|
      field.label = "Location"
      solr_name = solr_name("based_near", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('depositor') do |field|
      solr_name = solr_name("depositor", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('rights') do |field|
      solr_name = solr_name("rights", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    # label is key, solr field is value
    config.add_sort_field "score desc, #{uploaded_field} desc", label: "relevance"
    config.add_sort_field "#{uploaded_field} desc", label: "date uploaded \u25BC"
    config.add_sort_field "#{uploaded_field} asc", label: "date uploaded \u25B2"
    config.add_sort_field "#{modified_field} desc", label: "date modified \u25BC"
    config.add_sort_field "#{modified_field} asc", label: "date modified \u25B2"
    config.add_sort_field "#{title_field} asc", label: "title A-Z"
    config.add_sort_field "#{title_field} desc", label: "title Z-A"

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5
  end

  # disable the bookmark control from displaying in gallery view
  # Sufia doesn't show any of the default controls on the list view, so
  # this method is not called in that context.
  def render_bookmarks_control?
    false
  end
end
