class PageRequestsController < ApplicationController

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


end
