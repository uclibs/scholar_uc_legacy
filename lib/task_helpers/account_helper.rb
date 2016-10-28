module AccountHelper

  def generate_uc_account(sixplus2, first_name, last_name)
    unless User.where(email: "#{sixplus2}@ucmail.uc.edu").exists?
      password = Devise.friendly_token[0,20]
      email = "#{sixplus2}@ucmail.uc.edu"

      user = User.create user_does_not_require_profile_update: true, email: email, first_name: first_name, last_name: last_name, password: password, password_confirmation: password

      profile = Profile.new depositor: email
      profile.apply_depositor_metadata(user.user_key)
      profile.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
      profile.save

      person = Person.new depositor: email, email: email, profile: profile
      person.first_name = first_name
      person.last_name = last_name
      person.apply_depositor_metadata(user.user_key)
      person.read_groups = [Hydra::AccessControls::AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
      person.save

      user.repository_id = person.pid
      user.save
      user.provider = 'shibboleth'
      user.uid = "#{sixplus2}@uc.edu"
      user.save!

      person.read_groups = ['make_public']
      person.save!
      person.to_solr
      profile.to_solr
    end
  end

end
