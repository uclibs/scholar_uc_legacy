class PageRequestsController < ApplicationController

########
# if you're adding a new static page you must add it to both the 
# config/sitemap.rb file as well as the spec/sitemap/generator_spec.rb spec.
########

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
