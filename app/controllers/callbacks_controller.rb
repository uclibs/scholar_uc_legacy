class CallbacksController < Devise::OmniauthCallbacksController
  def shibboleth
    if current_user
      redirect_to landing_page
    else
      get_shibboleth_attributes
      create_or_update_account
      sign_in_shibboleth_user
    end
  end

  SUCCESS_NOTICE = "You have successfully connected with your Orcid account"
  def orcid
    omni = request.env["omniauth.auth"]
    Devise::MultiAuth.capture_successful_external_authentication(current_user, omni)
    redirect_to landing_page, notice: SUCCESS_NOTICE
  end

  private

  def get_shibboleth_attributes
    @omni = request.env["omniauth.auth"]
    @email = use_uid_if_email_is_blank
  end

  def create_or_update_account
    if user_exists?
      @profile = @user.profile
      @person = @user.person
      update_shibboleth_attributes if user_has_never_logged_in?
    else
      create_account
    end
  end

  def sign_in_shibboleth_user
    sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    cookies[:login_type] = "shibboleth"
    flash[:notice] = "You are now signed in as #{@user.name} (#{@user.email})"
  end

  def use_uid_if_email_is_blank
    # If user has no email address use their sixplus2@uc.edu instead
    # Some test accounts on QA/dev don't have email addresses
    if defined?(@omni.extra.raw_info.mail)
      if @omni.extra.raw_info.mail.blank?
        @email = @omni.uid
      else
        @email = @omni.extra.raw_info.mail
      end
    else
      @email = @omni.uid
    end
  end

  def user_exists?
    @user = User.find_by_provider_and_uid(@omni['provider'], @omni['uid'])
  end

  def update_shibboleth_attributes
    update_user_shibboleth_attributes
    update_profile_shibboleth_attributes
    update_person_shibboleth_attributes
  end

  def user_has_never_logged_in?
    @user.sign_in_count == 0
  end

  def create_account
    create_user
    create_profile
    create_person
    send_welcome_email
  end

  def create_user
    @user = User.create provider: @omni.provider, uid: @omni.uid, email: @email,
      password: Devise.friendly_token[0,20], user_does_not_require_profile_update: false
    update_user_shibboleth_attributes
  end

  def update_user_shibboleth_attributes
    @user.title        = @omni.extra.raw_info.title
    @user.telephone    = @omni.extra.raw_info.telephoneNumber
    @user.first_name   = @omni.extra.raw_info.givenName
    @user.last_name    = @omni.extra.raw_info.sn
    @user.ucstatus     = @omni.extra.raw_info.uceduPrimaryAffiliation
    @user.ucdepartment = @omni.extra.raw_info.ou
    @user.save
  end

  def create_profile
    @profile = Profile.create depositor: @user.email
    update_profile_shibboleth_attributes
    apply_deposit_authorization(@profile)
    @profile.save
  end

  def update_profile_shibboleth_attributes
    @profile.title = "#{@user.first_name} #{@user.last_name}"
    @profile.save
  end

  def create_person
    @person = Person.create depositor: @user.email, email: @user.email, profile: @profile
    update_person_shibboleth_attributes
    @user.repository_id = @person.pid
    apply_deposit_authorization(@person)
    @person.save
  end

  def update_person_shibboleth_attributes
    @person.first_name = @user.first_name
    @person.last_name = @user.last_name
    @person.title = @user.title
    @person.campus_phone_number = @user.telephone
    @person.save
  end

  def send_welcome_email
    WelcomeMailer.welcome_email(@email).deliver
  end

  def apply_deposit_authorization(target)
    target.apply_depositor_metadata(@user.user_key)
    target.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    target
  end

end
