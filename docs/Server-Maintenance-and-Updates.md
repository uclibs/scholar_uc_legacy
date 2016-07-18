### OS packages
RedHat updates are applied monthly by UCit using the following schedule:
* Dev: first Monday of the month
* QA: second Monday of the month
* Production: third Monday of the month

### ClamAV updates
A freshclam cron job runs every morning.  Virus definitions should never be more than 24 hours out of date.

### Ruby updates

Ruby should be updated periodically (especially for security updates).  UCit needs to be involved in the ruby upgrade since it requires root access and the puppet scripts needs to be updated.

New versions of Ruby can first be tested in local environments.

### Gem updates

Gems can be updated by running `bundle update` in a local environment and committing the updated Gemfile.lock file to the Git repository.  The server environment will then use the updated gems when the next deployment is done.