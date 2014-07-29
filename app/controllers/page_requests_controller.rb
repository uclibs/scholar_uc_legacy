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

end
