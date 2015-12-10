class CallbacksController < Devise::OmniauthCallbacksController
  def shibboleth
    unless current_user
      @omni = request.env["omniauth.auth"]
      @email = use_uid_if_email_is_blank

      unless user_exists?
        create_user
        create_profile
        create_person
      end

      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      flash[:notice] = "You are now signed in as #{@user.name} (#{@user.email})"
    else
      redirect_to catalog_index_path
    end
  end

  private

  def user_exists?
    @user = User.find_by_provider_and_uid(@omni['provider'], @omni['uid'])
  end

  def create_user
    @user = User.create provider: @omni.provider,
                             uid: @omni.uid,
                           email: @email,
                        password: Devise.friendly_token[0,20],
                           title: @omni.extra.raw_info.title,
                       telephone: @omni.extra.raw_info.telephoneNumber,
                      first_name: @omni.extra.raw_info.givenName,
                       last_name: @omni.extra.raw_info.sn,
                        ucstatus: @omni.extra.raw_info.uceduPrimaryAffiliation,
                    ucdepartment: @omni.extra.raw_info.ou,
                    user_does_not_require_profile_update: false
  end

  def create_profile
    @profile = Profile.create depositor: @user.email,
                                  title: "#{@user.first_name} #{@user.last_name}"

    apply_deposit_authorization(@profile)
    @profile.save
  end

  def create_person
    @person = Person.create depositor: @user.email,
                           first_name: @user.first_name,
                            last_name: @user.last_name,
                                email: @user.email,
                                title: @user.title,
                  campus_phone_number: @user.telephone,
                              profile: @profile

    @user.repository_id = @person.pid

    apply_deposit_authorization(@person)
    @person.save
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

  def apply_deposit_authorization(target)
    target.apply_depositor_metadata(@user.user_key)
    target.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
    target
  end

end

