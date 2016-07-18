**Note:** Deleting a user can have unintended consequences when there are delegates, groups, and other things tied to that user.

1. Ssh into one of the dev/QA/production web servers.

1. Change to the curate user:<br />`sudo su - curate`

1. Change to the application directory:<br />`cd /srv/apps/curate_uc`

1. Set the path to find bundler:<br />`export PATH=$PATH:/srv/apps/.gem/ruby/2.1.0/bin`

1. Start the rails console:<br />`bundle exec rails console`

1. Delete the user's **profile** record:<br />Example: `User.where(email: 'user@example.com').first.profile.delete`

1. Delete the user's **person** record:<br />Example: `User.where(email: 'user@example.com').first.person.delete`

1. Delete the user's **user** record:<br />Example: `User.where(email: 'user@example.com').first.delete`
