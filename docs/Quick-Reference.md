###Scholar@UC

#####Run entire test suite on Curate Gem
1. `cd curate_fork`
1. `bundle exec rake jetty:start`
1. `bundle exec rake spec` or if the test app doesn't exist yet `bundle exec rake clean generate spec`
1. `bundle exec rake spec`

#####Run some tests on Curate Gem
1. `cd curate_fork`
1. `bundle exec rake jetty:start`
1. `BUNDLE_GEMFILE=./spec/internal/Gemfile bundle exec rspec path/to/spec.rb:LINE`

#####Run entire test suite on Scholar application
1. `cd scholar_uc`
1. `bundle exec rake jetty:start`
1. `bundle exec rake spec`

#####Run some tests on Scholar application
1. `cd scholar_uc`
1. `bundle exec rake jetty:start`
1. `rspec path/to/spec.rb:LINE`

#####Delete a user
* See https://github.com/uclibs/scholar_uc/wiki/Deleting-user-accounts

***

###Hydra

#####solr
* Reindex: `bundle exec rake solr:reindex` (background workers need to be running)
* Reindex via the Rails console: `ActiveFedora::Base.reindex_everything`

***

###Ruby on Rails

#####Rails Console 
* Find a user: `User.find_by_email('user@exmaple.com')`
* Find a user by a column: `User.where(email: 'user@example.com')`
* Display certain fields: `User.select('first_name,last_name,email').all`
* Display results in yaml format: `y User.all`
* Mass update a column for multiple users: `User.update_all(department: 'IT')`
* Grep methods for a class: `User.methods.grep(/email/)`
* Change a user's password from console
    1. `u=User.where(:email => 'usermail@example.com').first`
    1. `u.password='userpassword'`
    1. `u.password_confirmation='userpassword'`
    1. `u.save`

#####Gems
* Install a gem: `gem install <gem name>`
* List installed versions of a gem: `gem list <gem name>`
* Delete a version of an installed gem: `gem uninstall <gem name>`

#####Comment out an entire block of code
* Put `=begin` above first line and `=end` below last line.

#####Wipe the rails database
* `bundle exec rake db:reset`

#####Debugging with byebug
* Add the byebug gem to your app: `gem 'byebug'`
* Add `byebug` to spot you want a breakpoint in your code
* Start rails server and watch the logging output
* Byebug commands:
    * help OR help <command>
    * n - next line
    * c - continue
    * eval - change data
    * finish
    * step - run one executable unit
    * q - quit
    * p <var> OR display <var> - display value of a variable
    * break <step #> - adds a breakpoint at <step #>

***

### Git

#####Rebase your feature branch on top of the develop branch
1. Change to your feature branch<br />`git checkout <your-feature-branch>`
1. `git stash` (if you have uncommitted changes)
1. `git checkout develop`
1. `git pull --rebase`
1. `git checkout <your-feature-branch>`
1. `git rebase develop`
1. `git stash pop` (if you stashed changes earlier)
1. Push your rebased branch up to GitHub<br />(a force push is usually required for rebased branches)<br />`git push -f origin <your-feature-branch>`

#####Squash commits
1. Make a backup or push your branch to GitHub just in case this fails.
1. Count the number of commits you need to squash.
1. `git rebase -i HEAD~#` (replace `#` with the number of commits)
1. When the editor opens, leave top commit as "pick" and change the others to "squash"
1. Save and exit the editor
1. When you push your branch up to GitHub you will need to include a `-f` switch so it will do a force push (e.g. `git push -f origin my-branch`)

***

### SCP

##### Getting your files from/to the servers

1. If you've done this before you'll need to clear host fingerprint for 127.0.0.1 at: ~/.ssh/known_hosts
1. First, on your local machine, run: `ssh -L 1234:SERVER_NAME:22 USERNAME@SECRET_SERVER_GATEWAY` (1234 could be any other unused port; SERVER_NAME is the target server; 22 is the standard port for ssh)
1. In a new session on your local machine, run: `scp -P 1234 USERNAME@127.0.0.1:/path/to/file /path/to/file`

***

###Miscellaneous 

#####Sync a copy of your local development files to Larry
* `rsync -avz -e ssh --delete /path/to/files username@larry.libraries.uc.edu:~/path/to/files`