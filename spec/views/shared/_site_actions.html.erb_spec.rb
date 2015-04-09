require 'spec_helper'

describe 'shared/_site_actions.html.erb' do

  before(:each) do
    view.stub(:current_user).and_return(current_user)
    render partial: 'shared/site_actions.html.erb'
  end

  def have_add_content_section(&block)
    have_tag('.add-content', &block)
  end

  def have_about_section(&block)
    have_tag('.list_pages', &block)
  end

  def have_help_section(&block)
    have_tag('.request-contact', &block)
  end

  def have_browse_section(&block)
    have_tag('.browse', &block)
  end

  context 'logged in' do
    let(:person) { double(pid: 'test:1234') }
    let(:name) { 'My Display Name' }
    let(:current_user) { User.new(name: name, person: person).tap {|u| u.stub(groups: ['registered'])} }
    it 'renders the add content and menu buttons' do
      expect(rendered).to have_add_content_section do
        with_tag '.quick-create' do
          with_tag 'a.link-to-full-list', with: { href: new_classify_concern_path }
          with_tag 'a.contextual-quick-classify', minimum: 3
          with_tag 'a.new-collection', with: { href: new_collection_path }, text: 'Add a Collection'
        end
      end
      expect(rendered).to have_about_section
      expect(rendered).to have_help_section
      expect(rendered).to have_browse_section
      end
  end

  context 'not logged in' do
    let(:current_user) { nil }
    it 'renders the menu buttons' do
      expect(rendered).to_not have_add_content_section
      expect(rendered).to have_about_section
      expect(rendered).to have_help_section
      expect(rendered).to have_browse_section
  end
  end
end
