#### Sandbox Gem Updates Procedure
1. Prerequisite:  Rebase uclibs/curate_fork gem from projecthydra/curate gem.
    1. One time mod: git remote add upstream https://github.com/projecthydra-labs/curate.git
    1. git fetch upstream 
    1. git checkout -b fork-updates
    1. git merge upstream/develop
    1. git push origin fork-updates
  
1. On a local machine (not sandbox)
    1. Pull down changes to scholar_uc from the "develop" branch `checkout develop; git pull origin`
    1. Create and create a new local branch called "gem-updates" `git checkout -b gem-updates`
    1. Edit the Gemfile to use 'fork-updates' branch.
    1. Run bundle update (make note of updated gems) `bundle update`
    1. Check if database migrations are needed `rake db:migrate`
    1. Check to see if generators need to be run or config files needs to be changed/created.
    1. Test the app on the local machine.  
         1. TEST SUCCESSFUL:  Merge fork-updates into develop on the curate_fork gem.  
               1. switch to curate_fork repository.
               1. 'git checkout develop'
               1. 'git merge fork-updates'
               1. 'git push origin develop'
         1. Then continue with application updates.
    1. Commit the changes `git add .; git commit -m "Update gems"`
    1. Push to GitHub `git push origin gem-updates`
1. On GitHub
    1. Open a pull request
    1. Merge the pull request into the "develop" branch
    1. Delete the "gem-updates" branch
1. On the sandbox
    1. Shut down the rails app
    1. From the application's directory, pull down changes from the remote develop branch `git pull`
    1. Switch to the "webapp" user `sudo -u webapp -s; source ~/.rvm/scripts/rvm`
    1. Run bundle update `bundle update`
    1. Check if database migrations are needed `rake db:migrate`
    1. Start the rails app `rails server -p 3001 -d`
    1. Test that everything is working
1. Write and publish the changelog.

System Updates
* Puppet
