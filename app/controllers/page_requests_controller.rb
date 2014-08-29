class PageRequestsController < ApplicationController

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

  def view_pres_pol
    render 'pres_policy'
  end

  def view_fair_use
    render 'fair_use'
  end

  def view_faq
    render 'faq'
  end


end
