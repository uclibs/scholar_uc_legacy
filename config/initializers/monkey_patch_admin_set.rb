# frozen_string_literal: true
# Override CC's AdminSet to load Sufia's updated AdminSetBehavior
AdminSet.include(Hyrax::AdminSetBehavior)
