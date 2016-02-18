SitemapGenerator::Sitemap.default_host = "https://scholar.uc.edu"
SitemapGenerator::Sitemap.create do

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

  Article.find_each do |article|
    add curation_concern_article_path(article), :priority => 0.8
  end
  Document.find_each do |document|
    add curation_concern_document_path(document), :priority => 0.8
  end
  Dataset.find_each do |dataset|
    add curation_concern_dataset_path(dataset), :priority => 0.8
  end
  Image.find_each do |image|
    add curation_concern_image_path(image), :priority => 0.8
  end
  GenericWork.find_each do |generic_work|
    add curation_concern_generic_work_path(generic_work), :priority => 0.8
  end
  Video.find_each do |video|
    add curation_concern_video_path(video), :priority => 0.8
  end
  Collection.find_each do |collection|
    add collection_path(collection), :priority => 0.8
  end

end
