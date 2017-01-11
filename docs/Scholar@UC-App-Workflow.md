**Note:** If changes have been committed to the curate gem, be sure to merge them into the gem's master branch.

1. Clone the scholar_uc repo<br />`git clone git@github.com:uclibs/scholar_uc.git`<br />`cd scholar_uc`

1. Run the script to update the local config files.<br />`script/copy_config_local.sh`

1. Create a new feature branch based on the **2.x-stable** branch<br />`git checkout 2.x-stable`<br />`git pull`<br />`git checkout -b feature/#issuenum-branch-name`

1. Run bundler. (if bundler fails with mysql errors, comment out `gem 'mysql2'` in the Gemfile and run bundler again)<br />`bundle install`

1. Install hydra-jetty if you don't already have it.<br />`rails g hydra:jetty`

1. Start hydra-jetty.<br />`bundle exec rake jetty:start`

1. Run the database migrations.<br />`bundle exec rake db:migrate`

1. Start the rails server.<br />`rails server`

1. Make sure the app is up and running.<br />[http://localhost:3000](http://localhost:3000)

1. Make your changes.

1. Commit your changes to local Git repository.

1. If updates have been made to the Curate gem, edit the Gemfile to point to latest commit.

1. Run spec tests locally.  Make sure they all pass. <br />`bundle exec rake spec`

1. Push changes to remote feature branch. <br />`git push origin feature/#issuenum-branch-name`

1. On github.com, open a new pull request for your feature branch.

1. Make sure Travis passes. https://travis-ci.org/uclibs/scholar_uc

1. After someone else has merged the pull request, delete the feature branch.  **Do not merge your own pull requests.**

1. Close the resolved issue.

1. Update the **CHANGELOG.md** with changes for this release

1. [Deploy to dev server] (Scholar@UC-App-Deployment-Procedures)

1. Create a **release** branch based on the **2.x-stable** branch.<br />`git checkout -b release`

1. Make any changes and commits needed.

1. Push the release branch to GitHub<br />`git push origin release`

1. [Deploy to QA server] (Scholar@UC-App-Deployment-Procedures)

1. Run through the [test script] (Scholar@UC-Test-Script) on the QA server

1. Complete the Risk Assessment and determine if a hailstorm scan is needed.

1. Complete the Change Management Form.

1. Merge the **release** branch into the **master** branch AND the **2.x-stable** branch.<br />`git checkout release`<br />`git pull`<br />`git checkout master`<br />`git pull`<br />`git merge release`<br />`git checkout 2.x-stable`<br />`git pull`<br />`git merge release`

1. If changes were made to the curate gem, update the Gemfile to point to the most recent commit in the curate master branch.

1. Push the master and 2.x-stable branches to GitHub<br />`git checkout 2.x-stable`<br />`git push origin 2.x-stable`<br />`git checkout master`<br />`git push origin master`

1. In the master branch, tag a new release in Git and push it to the remote<br />`git checkout master`<br />ex. `git tag -a v1.4.0 -m '10-01-2014'`<br />`git push --tags`

1. Also tag the Curate gem master branch with the same version number<br />`cd ../curate`<br />`git checkout master`<br />`git pull`<br />ex. `git tag -a v1.4.0 -m '10-01-2014'`<br />`git push --tags`

1. [Deploy to production server] (Scholar@UC-App-Deployment-Procedures) (**after change request has been approved**)

1. Post announcement to ScholarBlog

1. Delete the local and remote **release** branches.<br />`git branch -d release`<br />`git push origin :release`

1. [Close the milestone if not already done](https://github.com/uclibs/scholar_uc/milestones)

1. The person that submitted the change request should provide an outcome on the change management website.
