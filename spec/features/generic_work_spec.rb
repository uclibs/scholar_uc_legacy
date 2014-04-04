require 'spec_helper'

describe 'Creating a generic work' do
  let(:person) { FactoryGirl.create(:person_with_user) }
  let(:user) { person.user }

  it 'defaults to open visibility' do
    login_as(user)
   	visit new_curation_concern_generic_work_path
	  expect(page).to have_checked_field('visibility_open')
  end
end
