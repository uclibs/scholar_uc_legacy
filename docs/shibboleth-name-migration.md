# Issues:

* Modify shibbloleth changes to handle firstname and last name in registrations
    * Glen is on it!
* Pulling the migration from curate_fork into Scholar_uc
    * `db/migrate/20150423153556_add_family_name_and_given_name_to_user.rb`
* File overrides - Scholar_uc vs curate_fork
    * `app/views/registrations/_form_attributes.html.erb`
* What do we need to do to change a regular account to a shibbolized account?
    * Set `provider` to `'shibboleth'`
    * Set `uid` to the user's email address
* How to best edit the name?
    * Manually
* How to best edit work/file access? (if the email address changes)
    * Might need to manually touch all files to re-set editors

#Migration script
```ruby
##############
# 
#   Migration script for scholar@uc.edu
#
#   Paste functions into Rails Console individually rather than all at once 
#     - it gets a little wonky after too many lines
#   Usage: change_email('old_email', 'new_email', 'pid')
#
##############

def change_email(old_email, new_email, pid)
  p = ActiveFedora::Base.find(pid: pid).first
  case p.class.name
    when 'Article'
      depositor(p, old_email, new_email)
      owner(p, old_email, new_email)
      edit_users(p, old_email, new_email)
    when 'GenericWork'
      depositor(p, old_email, new_email)
      owner(p, old_email, new_email)
      edit_users(p, old_email, new_email)
    when 'Document'
      depositor(p, old_email, new_email)
      owner(p, old_email, new_email)
      edit_users(p, old_email, new_email)
    when 'Dataset'
      depositor(p, old_email, new_email)
      owner(p, old_email, new_email)
      edit_users(p, old_email, new_email)
    when 'Image'
      depositor(p, old_email, new_email)
      owner(p, old_email, new_email)
      edit_users(p, old_email, new_email)
    when 'GenericFile'
      depositor(p, old_email, new_email)
      owner(p, old_email, new_email)
      edit_users(p, old_email, new_email)
    when 'LinkedResource'
      depositor(p, old_email, new_email)
      owner(p, old_email, new_email)
      edit_users(p, old_email, new_email)
    when 'Collection'
      depositor(p, old_email, new_email)
      edit_users(p, old_email, new_email)
    when 'Person'
      depositor(p, old_email, new_email)
      profile_depositor(p, old_email, new_email)
      email(p, old_email, new_email)
      user_email(p, old_email, new_email)
    when 'Hydramata::Group'
      depositor(p, old_email, new_email)
      edit_users(p, old_email, new_email)
    else
      puts 'Type not found!'
  end
end

def email(p, old_email, new_email)
  if p.email == old_email
    p.email = new_email
    p.save
    puts "\tEmail updated"
  else
    puts "\tEmail doesn't match!"
  end
end

def depositor(p, old_email, new_email)
  if p.depositor == old_email
    p.depositor = new_email
    p.save
    puts "\tDepositor updated"
  else
    puts "\tDepositor input email doesn't match!"
  end
end

def owner(p, old_email, new_email)
  if p.owner == old_email
    p.owner = new_email
    p.save
    puts "\tOwner updated"
  else
    puts "\tOwner input email doesn't match!, or may be Generic file with no owner"
  end
end

def edit_users(p, old_email, new_email)
  e_users = p.edit_users
  if e_users.include? old_email
    e_users.each_index do |i|
      e_users[i] = new_email if e_users[i] == old_email
    end
    p.edit_users = e_users
    p.save
    puts "\tEdit Users updated"
  else
    puts "\tEdit Users email doesn't match!"
  end
end
  
def user_email(p, old_email, new_email)
  if p.user.email == old_email
    p.user.email = new_email
    p.user.save
    puts "\tUser email update"
  else
    puts "\tUser email doesn't match!"
  end
end

def profile_depositor(p, old_email, new_email)
  if p.profile.depositor == old_email
    p.profile.depositor = new_email
    p.profile.save
    puts "\tProfile depositor updated"
  else
    puts "\tProfile depositor doesn't match!"
  end
end
```