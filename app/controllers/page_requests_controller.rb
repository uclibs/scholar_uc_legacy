class PageRequestsController < ApplicationController

  ########
  ## if you're adding a new static page you must add it to both the 
  ## config/sitemap.rb file as well as the spec/sitemap/generator_spec.rb spec.
  #########

  def splash_page
    render 'page_requests/splash_index', layout: false
  end

end
