require 'spec_helper'

describe 'curate/people/show.html.erb' do
  let(:person) { FactoryGirl.create(:person_with_user) }
  #let(:user) { person.user }
  let(:user) { User.new(first_name: 'Iron', last_name: 'Man', person: person) }
  #let(:user) { FactoryGirl.create(:user, name: 'Iron Man', first_name: 'Iron', last_name: 'Man', person: person) }
  #let(:user) { User.new(name: 'Iron Man', person: person) }

  context 'A person who has a profile' do

    before do
      assign :person, person
      controller.stub(:current_user).and_return(user)
      render
    end

    context 'with logged in user' do

      it 'does not display first and last name' do
        expect(rendered).to_not have_content('Iron Man')
      end
    end

  end

  context 'with an empty profile and not logged in' do

    before do
      assign :person, person
      controller.stub(:current_user).and_return(user)
      render
    end

    let(:user) { nil }
    it 'should render the person profile section' do
      assert_select '#person_profile' do
        assert_select '#documents', count: 0
        assert_select '#no-documents', count: 0
        assert_select '.form-action', count: 0
      end
    end
  end


end
