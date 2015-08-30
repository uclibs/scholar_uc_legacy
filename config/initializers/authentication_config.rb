#AUTH_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/authentication.yml")[RAILS_ENV]
AUTH_CONFIG = YAML.load_file(Rails.root.join('config', 'authentication.yml'))[Rails.env]
