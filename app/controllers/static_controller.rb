# frozen_string_literal: true
# comment forced by rubocop
class StaticController < ApplicationController
  def about
    render "static/about"
  end

  def coll_policy
    render "static/coll_policy"
  end

  def format_advice
    render "static/format_advice"
  end

  def faq
    render "static/faq"
  end

  def distribution_license
    render "static/distribution_license"
  end

  def documenting_data
    render "static/documenting_data_help"
  end

  def creators_rights
    render "static/creators_rights"
  end
end
