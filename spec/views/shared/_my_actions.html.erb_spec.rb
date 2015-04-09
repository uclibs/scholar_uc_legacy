require 'spec_helper'

describe 'shared/_my_actions.html.erb' do

  before(:each) do
    view.stub(:current_user).and_return(current_user)
    render partial: 'shared/my_actions.html.erb'
  end

  context 'logged in' do
    let(:person) { double(pid: 'test:1234') }
    let(:name) { 'My Display Name' }
    let(:current_user) { User.new(name: name, person: person).tap {|u| u.stub(groups: ['registered'])} }
    it 'renders the user actions menu' do
      expect(rendered).to have_tag('a.my-works')
      expect(rendered).to have_tag('a.my-collections', with: { href: collections_path})
      expect(rendered).to have_tag('a.my-account', with: { href: user_profile_path })
      expect(rendered).to have_tag('a.my-proxies', with: { href: person_depositors_path('1234') })
      expect(rendered).to have_tag('a.log-out', with: { href: destroy_user_session_path })
   end
  end
end
