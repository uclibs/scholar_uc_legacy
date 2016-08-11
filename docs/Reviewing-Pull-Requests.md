1. Checkout the branch you are reviewing
<br />`git checkout branch-name`

1. Run bundler
<br />`bundle install`

1. For Hydra applications, start Jetty
<br />`bundle exec rake jetty:start`

1. If you are reviewing a branch in the Curate gem, generate the test application
<br />`bundle exec rake clean generate`

1. Run the automated tests
<br />`bundle exec rake spec`

1. Start the application and manually test the new feature/fix (if you are reviewing a branch in the Curate gem, point a local copy of scholar_uc at the gem branch.)
<br />`bundle exec rails server`

1. Look over the code itself for any problems.

1. If you encounter problems with any of the above steps, comment on the pull request. Otherwise, merge the pull request and delete the branch.  If you think another person should also review the pull request, just give it a thumbs up in the comments.
