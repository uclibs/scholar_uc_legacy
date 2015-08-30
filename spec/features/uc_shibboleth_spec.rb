require 'spec_helper'

describe 'UC account workflow', FeatureSupport.options do
  let(:password) { FactoryGirl.attributes_for(:user).fetch(:password) }
  let(:account) { FactoryGirl.create(:account) }
  let(:user) { account.user }

  filepath = "config/authentication.yml"
  yaml = YAML.load_file(filepath)

  describe 'overridden devise password reset page' do
    email_address = 'fake.user@uc.edu'
    it 'rejects password reset for @.uc.edu user' do
      visit new_user_password_path
      fill_in('user[email]', with: email_address)
      click_on('Send me reset password instructions')
      page.should have_content('You cannot reset passwords for @uc.edu accounts. Use your UC Central Login instead')
    end
  end

  describe 'overridden devise password reset page' do
    it 'shows a Central Login option' do
      visit new_user_password_path
      page.should have_content('Central Login form')
    end

    it 'does not display the Shared links at the bottom' do
      visit new_user_password_path
      expect(page).to_not have_link('Sign in', href: '/users/sign_in')
      expect(page).to_not have_link('Sign up', href: '/users/sign_up')
    end
  end

  describe 'overridden devise registration page' do
    it 'shows a sign up form if signups are enabled or a request link if signups are disabled' do
      visit new_user_registration_path
      if yaml['test']['signups_enabled'] == true
        page.should have_field('user[email]')
      else
        expect(page).to have_link('use the contact page', href: '/contact_requests/new')
      end
    end
  end

  describe 'overridden devise sign-in page' do
    it 'shows a shibboleth login link if shibboleth is enabled' do
      visit new_user_session_path
      if yaml['test']['shibboleth_enabled'] == true
        expect(page).to have_link('Central Login form', href: '/users/auth/shibboleth')
      else
        expect(page).to_not have_link('Central Login form', href: '/users/auth/shibboleth')
      end
    end

    it 'shows a signup link if signups are enabled' do
      visit new_user_session_path
      if yaml['test']['signups_enabled'] == true
        page.should have_link('Sign up', new_user_registration_path)
      else
        page.should_not have_link('Sign up', new_user_registration_path)
      end
    end
  end

  describe 'shibboleth login page' do
    it 'shows a shibboleth login link and local login link if shibboleth is enabled' do
      visit login_path
      if yaml['test']['shibboleth_enabled'] == true
        expect(page).to have_link('UC Central Login username', href: 'https://www.uc.edu/distance/Student_Orientation/One_Stop_Student_Resources/central-log-in-.html')
        expect(page).to have_link('log in using a local account', new_user_session_path)
      else
        page.should have_field('user[email]')
      end
    end
  end

  describe 'overridden form profile form attributes page' do
    it 'shows read only form fields' do
      login_as(user)
      user.provider = 'shibboleth'
      visit edit_user_registration_path
      if yaml['test']['shibboleth_enabled'] == true
        page.should have_field("user[ucdepartment]")
        page.should have_field("user[ucstatus]")
      else
        page.should_not have_field("ucdepartment")
        page.should_not have_field("ucstatus")
      end
    end
  end

  describe 'shibboleth password management' do
    it 'hides the password change fields for shibboleth users' do
      login_as(user)
      user.provider = 'shibboleth'
      visit edit_user_registration_path
        page.should_not have_field("user[password]")
        page.should_not have_field("user[password_confirmation]")
    end
  end

  describe 'home page login button' do
    it 'shows the correct login link for users' do
      visit root_path
      if yaml['test']['shibboleth_enabled'] == true
        expect(page).to have_link('Log In', login_path)
      else
        expect(page).to have_link('Log In', new_user_session_path)
      end
    end
  end

  describe 'a shiboleth user updating their profile' do
    it 'does not require a password to save cahnges' do
      login_as(user)
      user.provider = 'shibboleth'
      user.save
      new_title = 'shibboleth person'

      visit edit_user_registration_path

      within('form.edit_user') do
        fill_in("user[title]", with: new_title)
        click_button("Update")
      end

      expect(page).to have_content 'You updated your account successfully'
    end
  end
end
