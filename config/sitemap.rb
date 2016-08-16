SitemapGenerator::Sitemap.default_host = Curate.configuration.application_root_url

SitemapGenerator::Sitemap.create(:compress => false) do

# config file for sitemap_generator. Generates public/sitemap.xml.gz
# run the rake tasks to generate updated versions
#       `rake sitemap:refresh` on production, 
#       `rake sitemap:refresh:no_ping` on development
#
# https://github.com/kjvarga/sitemap_generator

### static links ###
  add '/catalog', :priority => 1, :changefreq => 'daily'
  add '/users/sign_in', :priority => 0.8, :changefreq => 'monthly'
  add '/contact_requests/new', :priority => 0.8, :changefreq => 'monthly'
  add '/about_request', :priority => 1, :changefreq => 'monthly'
  add '/terms_request', :priority => 0.8, :changefreq => 'monthly'
  add '/coll_pol_request', :priority => 0.8, :changefreq => 'monthly'
  add '/format_advice_requests', :priority => 0.8, :changefreq => 'monthly'
  add '/faq_request', :priority => 0.8, :changefreq => 'monthly'
  add '/creators_rights_request', :priority => 0.8, :changefreq => 'monthly'
  add '/orcid_about', :priority => 0.8, :changefreq => 'monthly'

### major facets ###
  add '/catalog?f[human_readable_type_sim][]=Article', :priority => 0.8, :changefreq => 'monthly'
  add '/catalog?f[human_readable_type_sim][]=Document', :priority => 0.8, :changefreq => 'monthly'
  add '/catalog?f[human_readable_type_sim][]=Dataset', :priority => 0.8, :changefreq => 'monthly'
  add '/catalog?f[human_readable_type_sim][]=Image', :priority => 0.8, :changefreq => 'monthly'
  add '/catalog?f[human_readable_type_sim][]=Video', :priority => 0.8, :changefreq => 'monthly'
  add '/catalog?f[human_readable_type_sim][]=Collection', :priority => 0.8, :changefreq => 'monthly'
  add '/catalog?f[human_readable_type_sim][]=Generic+Work', :priority => 0.8, :changefreq => 'monthly'
  add '/catalog?f[human_readable_type_sim][]=Person', :priority => 0.8, :changefreq => 'monthly'


### curation concerns ###
  Curate.configuration.registered_curation_concern_types.each do |curation_concern_type|
    curation_concern_type.constantize.find_each do |curation_concern|
      if curation_concern.read_groups == ["public"]
        add polymorphic_path([:curation_concern, curation_concern]), :priority => 0.8
      end
    end
  end

  Collection.find_each do |collection|
    if collection.read_groups == ["public"]
      add collection_path(collection)
    end
  end

  Person.find_each do |person|
    if person.read_groups == ["public"]
      add person_path(person), :priority => 0.8
    end
  end
end
