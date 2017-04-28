# frozen_string_literal: true
GENRE_TYPES_DOCUMENT = YAML.load(File.open(Rails.root.join('config/authorities/genre_types_document.yml'))).freeze if File.exist?(Rails.root.join('config/authorities/genre_types_document.yml'))

GENRE_TYPES_IMAGE = YAML.load(File.open(Rails.root.join('config/authorities/genre_types_image.yml'))).freeze if File.exist?(Rails.root.join('config/authorities/genre_types_image.yml'))

GENRE_TYPES_STUDENTWORK = YAML.load(File.open(Rails.root.join('config/authorities/genre_types_student_work.yml'))).freeze if File.exist?(Rails.root.join('config/authorities/genre_types_student_work.yml'))
