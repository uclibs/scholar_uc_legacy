The following is a procedure for creating user accounts on scholar.uc.edu.

1. `ssh vbbssh.ad.uc.edu`

1. `ssh libhydpwl1.private`

1. `sudo su - curate`

1. `cd curate_uc`

1. `export PATH=$PATH:/srv/apps/.gem/ruby/2.1.0/bin`

1. `bundle exec rails console`

1. Adjust the variables below and paste them into the console:

        email = 'user@example.com'
        password = 'pass1234'
        first_name = 'John'
        last_name = 'Doe'
 
1. Copy and paste the code block below into the console:

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
exit

Test the new user's login and then put the credentials in a https://privnote.com and email them the link.