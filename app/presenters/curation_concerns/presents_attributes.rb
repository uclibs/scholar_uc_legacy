# frozen_string_literal: true
require CurationConcerns::Engine.root.join('app/presenters/curation_concerns/presents_attributes.rb')
module CurationConcerns
  module PresentsAttributes
    def submitter_profile
      user = ::User.find_by_email(depositor)
      path = Sufia::Engine.routes.url_helpers.profile_path(user)
      "<tr><th>Submitter</th>\n<td><ul class='tabular'><li class=\"attribute depositor\"><a href=\"#{path}\">#{user.name}</a></li></ul></td></tr>"
    end
  end
end
