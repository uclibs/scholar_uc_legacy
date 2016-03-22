# spec/features/generator_spec.rb
require 'spec_helper'
require 'rake'

#####
# if the test breaks because of a BadUri (both uri relative), run script/copy_config_local.sh
#####

describe SitemapGenerator::Interpreter do
  describe '.run' do
    it 'does not raise an error' do
      allow(SitemapGenerator::Sitemap).to receive(:ping_search_engines).and_return true
      allow(SitemapGenerator::Sitemap).to receive(:create).and_yield
      # Create some test data here with FactoryGirl
      expect { described_class.run }.not_to raise_error
    end
  end
  describe 'sitemap file' do
      let!(:public_person) {FactoryGirl.create(:person_with_user, read_groups: ["", "public"])}
      let!(:user) {public_person.user}
      let!(:private_person) {FactoryGirl.create(:person)}
      let!(:collection) {FactoryGirl.create(:collection, read_groups: ["public"])}
      let!(:private_collection) { FactoryGirl.create(:collection, read_groups: [])}
      let!(:generic_work) {FactoryGirl.create(:generic_work, read_groups: ["public"])}
      let!(:private_generic_work) {FactoryGirl.create(:generic_work, read_groups: [])}
    before(:each) do
      #static links
      Curate.configuration.application_root_url = 'http://localhost:3000/'
      @catalog_url = 'http://localhost:3000/catalog'
      @sign_in_url = 'http://localhost:3000/users/sign_in'
      @contact_requests_url = 'http://localhost:3000/contact_requests/new'
      @about_request_url = 'http://localhost:3000/about_request'
      @terms_request_url = 'http://localhost:3000/terms_request'
      @collection_poll_url = 'http://localhost:3000/coll_pol_request'
      @format_advice_url = 'http://localhost:3000/format_advice_requests'
      @faq_url = 'http://localhost:3000/faq_request'
      @creator_rights_url = 'http://localhost:3000/creators_rights_request'
      #major facets
      @article_facet_url = 'http://localhost:3000/catalog?f[human_readable_type_sim][]=Article'
      @document_facet_url = 'http://localhost:3000/catalog?f[human_readable_type_sim][]=Document'
      @dataset_facet_url = 'http://localhost:3000/catalog?f[human_readable_type_sim][]=Dataset'
      @image_facet_url = 'http://localhost:3000/catalog?f[human_readable_type_sim][]=Image'
      @video_facet_url = 'http://localhost:3000/catalog?f[human_readable_type_sim][]=Video'
      @collection_facet_url = 'http://localhost:3000/catalog?f[human_readable_type_sim][]=Collection'
      @generic_work_facet_url = 'http://localhost:3000/catalog?f[human_readable_type_sim][]=Generic+Work'
      @person_facet_url = 'http://localhost:3000/catalog?f[human_readable_type_sim][]=Person'

    end
    it 'generates only public users with works submitted and public new works or public collections' do
      login_as(user)
      visit new_curation_concern_generic_work_path
      within '#new_generic_work' do
        fill_in "Title", with: "Submitter profile link test"
        fill_in "Description", with: "test description"
        fill_in "generic_work_creator", with: "Test generic work creator"
        check("I have read and accept the distribution license agreement")
        click_button("Create Generic work")
      end
      load File.expand_path("../../../Rakefile", __FILE__)
      Rake::Task.define_task(:environment)
      Rake::Task['sitemap:refresh:no_ping'].invoke
      File.read('public/sitemap.xml').should include(person_path(public_person))
      File.read('public/sitemap.xml').should_not include(person_path(private_person))
      File.read('public/sitemap.xml').should include(curation_concern_generic_work_path(generic_work))
      File.read('public/sitemap.xml').should_not include(curation_concern_generic_work_path(private_generic_work))
      File.read('public/sitemap.xml').should include(collection_path(collection))
      File.read('public/sitemap.xml').should_not include(collection_path(private_collection))

    end
    it 'contains the correct static urls' do
      #check for all static links
      File.read('public/sitemap.xml').should include(@catalog_url)
      File.read('public/sitemap.xml').should include(@sign_in_url)
      File.read('public/sitemap.xml').should include(@contact_requests_url)
      File.read('public/sitemap.xml').should include(@about_request_url)
      File.read('public/sitemap.xml').should include(@terms_request_url)
      File.read('public/sitemap.xml').should include(@collection_poll_url)
      File.read('public/sitemap.xml').should include(@format_advice_url)
      File.read('public/sitemap.xml').should include(@faq_url)
      File.read('public/sitemap.xml').should include(@creator_rights_url)
      File.read('public/sitemap.xml').should include(@article_facet_url)
      File.read('public/sitemap.xml').should include(@document_facet_url)
      File.read('public/sitemap.xml').should include(@dataset_facet_url)
      File.read('public/sitemap.xml').should include(@image_facet_url)
      File.read('public/sitemap.xml').should include(@video_facet_url)
      File.read('public/sitemap.xml').should include(@collection_facet_url)
      File.read('public/sitemap.xml').should include(@generic_work_facet_url)
      File.read('public/sitemap.xml').should include(@person_facet_url)
    end
  end
end
