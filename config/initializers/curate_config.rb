Curate.configure do |config|
  config.register_curation_concern :generic_work
  config.register_curation_concern :dataset
  config.register_curation_concern :article
  config.register_curation_concern :etd
  config.register_curation_concern :image
  config.register_curation_concern :document
  # # You can override curate's antivirus runner by configuring a lambda (or
  # # object that responds to call)
  # config.default_antivirus_instance = lambda {|filename| … }

  # # Used for constructing permanent URLs
  # config.application_root_url = 'https://repository.higher.edu/'

  # # Override the file characterization runner that is used
  # config.characterization_runner = lambda {|filename| … }
end
