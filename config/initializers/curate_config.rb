Curate.configure do |config|
  config.register_curation_concern :generic_work
  config.register_curation_concern :dataset
  config.register_curation_concern :article
  config.register_curation_concern :image
  config.register_curation_concern :document
  config.register_curation_concern :video
  # # You can override curate's antivirus runner by configuring a lambda (or
  # # object that responds to call)
  # config.default_antivirus_instance = lambda {|filename| … }

  # # Used for constructing permanent URLs
  config.application_root_url = 'bamboo_application_url'

  # # Override the file characterization runner that is used
  # config.characterization_runner = lambda {|filename| … }

  # # Used to load values for constructing SOLR searches
  search_config_file = File.join(Rails.root, 'config', 'search_config.yml')
  config.search_config = YAML::load(File.open(search_config_file))[Rails.env].with_indifferent_access
end
