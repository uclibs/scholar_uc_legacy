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

  def student_work_help
    render "static/student_work_help"
  end

  def advisor_guidelines
    render "static/advisor_guidelines"
  end

  def student_instructions
    render "static/student_instructions"
  end
end
