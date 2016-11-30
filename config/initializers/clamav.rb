# frozen_string_literal: true
ClamAV.instance.loaddb if Rails.env.production?
