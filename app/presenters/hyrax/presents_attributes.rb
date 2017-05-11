# frozen_string_literal: true
require Hyrax::Engine.root.join('app/presenters/hyrax/presents_attributes.rb')
module Hyrax
  module PresentsAttributes
    def submitter_profile
      user = ::User.find_by_email(depositor)
      path = Hyrax::Engine.routes.url_helpers.profile_path(user)
      "<tr><th>Submitter</th>\n<td><ul class='tabular'><li class=\"attribute depositor\"><a href=\"#{path}\">#{user.name}</a></li></ul></td></tr>"
    end
  end
end
