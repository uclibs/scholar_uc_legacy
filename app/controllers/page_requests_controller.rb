class PageRequestsController < ApplicationController

########
# if you're adding a new static page you must add it to both the 
# config/sitemap.rb file as well as the spec/sitemap/generator_spec.rb spec.
########

  def view_student_instructions
    render 'student_instructions'
  end

  def view_advisor_guidelines
    render 'advisor_guidelines'
  end

  def view_student_works_help
    render 'student_work_help'
  end

  def view_orcid_about
    render 'orcid_about'
  end

  def view_distribution_license
    render 'distribution_license'
  end

  def view_terms
    render 'terms'
  end

  def view_about
    render 'about'
  end

  def view_presentation
    render 'presentation'
  end

  def view_coll_pol
    render 'coll_policy'
  end

  def view_format_advice
    render 'format_advice'
  end

  def view_faq
    render 'faq'
  end

  def view_contact
    render 'contact'
  end

  def view_creators_rights
    render 'creators_rights'
  end

  def view_data_help
    render 'documenting_data_help'
  end

  def login
    if current_user
      redirect_to landing_page
    elsif AUTH_CONFIG['shibboleth_enabled']
      render 'login'
    else
      redirect_to new_user_session_path
    end
  end
end
