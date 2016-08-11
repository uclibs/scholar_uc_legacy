1. [Wipe the QA environment of all content and users.] (How-to-Wipe-All-Content-in-Scholar-and-Fedora)

1. Create the Hailstorm user by copying and pasting the block of commands below into the **rails console**  on one of the QA web servers.  The entire block can be copied and pasted at the same time to the console prompt. (the password is not used and doesn't matter):

        email = 'jsmith20@kelev.biz'
        password = 'pass1234'
        first_name = 'Hailstorm'
        last_name = 'User'
        title = 'Hailstorm Scan'
        telephone = '+1 513 555 5555'
        uid = 'hortongn@uc.edu'
        user = User.create user_does_not_require_profile_update: true, email: email, first_name: first_name, last_name: last_name, password: password, password_confirmation: password, title: title, telephone: telephone, provider: "shibboleth", uid: uid, ucstatus: "Staff", ucdepartment: "UCL Digital Collections & Repositories"
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

1. Go to https://hailstorm.uc.edu, select the **_Scholar 2015.08.17 as colemaj6 (manager)** application, and queue up sets A-M in alphabetical order.