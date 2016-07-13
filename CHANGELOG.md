### 2.0.0 7/13/2016
* Add more slots for manager accounts.	
* Search within a collection.
* Enable date_created as a facet option in catalog.
* The label Numeric Sort is changed to Frequency Sort when displaying all facets.
* E-mail Notifications on adding and removing memberships.  (Delegate, Editor, or Group)
* Enable alpha-numeric title sort in Catalog Browse. 
* Bug fixes
  * Profiles with selected works break for non-logged in.
  * Enable creator display for document work type in catalog.
  * Switches GET to POST to solve large membership problem.
  * Style and Label updates to ETD’s.
* Security 
  * Resolve Imagemagick vulnerability.
  * Upgrade Fedora to 3.8.1.
  * Prevent links to repo manager on work show page.
  
### 1.11.0 6/7/2016
* Added a new license selector when creating a new work
* Added a new work type for electronic theses and dissertations
* Added a new user role for electronic theses and dissertations
* Collection show pages now list the collection owner's name
* Thumnails are now treated as clickable links
* Bug fixes
  * Pinned google_drive and google-api-client gems (browse-everything fix)
  * Added a missing </div> table to the work change owner form
  * Added a "Your Profile" label to collection assignment dialog
  * Fixed line breaks in collection and group descriptions
  * Submitters can no longer add someone else’s work to be featured on their main profile page.  Submitters can still add someone else’s work to a profile section.   Submitters who previously added another user’s work to their main profile page, should now be able to remove this work from that page. 

### 1.10.0 5/24/2016
* Allows Repository Manager to change owner on works.
* Creates worker for ownership clean up.
* Displays parent-child relationship on collection page.
* Bug fixes
  * Attributes with line breaks rendering without line breaks.
  * Removes additional information on catalog view.
  * Removes double slash on profile page link.
  * Fixes thumbnail display on collection show page.
  * Replaces email with name for collections in catalog browse view.

### 1.9.0 5/10/2016
* Creates new Student Work work type.
* Removes turbolinks.
* Gem Updates
  * httpclient 2.8.0 (was 2.7.1)
  * multi_json 1.11.3 (was 1.11.2)
  * redis 3.3.0 (was 3.2.2)
  * tzinfo 0.3.49 (was 0.3.48)
* Bug fixes
  * On Video work type:  Sets default value of date_created to blank.
  * Makes deposited file owner the same as parent work.
  * Resolves double slash on profile permalinks.
  * Moves data help alert to data view override.
  * Fixes bug with bad registrations.

### 1.8.1 4/22/2016
* Improves Dataset documentation.
* Bug fixes
  * Improves user lookup field for delegate to include email address
  * Improves mobile display
  * Links to profile collections should link to people
  * Owner is set properly on files ingested at the same time work is created
  * Unpin rake from 10.5

### 1.8.0 4/1/2016
* Email notification on user registration
* Enhances user lookup fields to include email address
* Bug fixes
  * Fix bug that causes some collection avatars to to not display
  * Fix seed data and rake build tasks for engine
  * Fix bug to handle trailing white space in metadata fields
  * Fix last name, first name display when depositing on behalf of user

### 1.7.1 3/18/2016
* Bug fixes
  * Fix bug that causes some user profiles to to not display
  * Fix bug that includes private works or collections in the sitemap.xml

### 1.7.0 3/4/2016
* Improved the display of file metadata for mobile users
* Prevent the use of script tags in all form fields
* The page footer now diplays the date and time of the last code deploy
* Added a link to the File Format Advice page at the top of the new work form
* Users can now reserve Document Object Indentifiers (DOIs) for embargoed/private works
* When viewing a work, the name of that work's submitter is now listed
* The sitemap.xml file is now generated nightly and includes works, collections, and profiles
* Bug fixes
  * Only show the Adobe Reader link once when there are multiple PDfs listed on a page
  * Fixed the display of very long file names when viewing a work
  * Various display fixes for the mobile responsive layout
  * Fixed bugs related to the video work type introduced in v1.6

### 1.6.0 2/5/2016
* Removed the contact form captcha requirement for logged in users.
* Added the ability to assign read-only permissions to individuals or to a group.
* Added a new work type for video content.
* Added an embedded image viewer.
* Bug fixes
  * Editor rights from additional editors are now also granted to linked resources.
  * Required form fields no longer accept only space characters as valid content.
  * Users are now properly hidden until they own a work.
  * All form fields now reject content that includes HTML script tags.

### 1.5.1 2/1/2016
* Bugs fixes
  * Fixed a bug where nested collections would not display
  * Fixed an incorrect URL for production Shibboleth logout

### 1.5 1/22/2016
* When users view a list of their collections, the list is now sorted alphabetically.
* Pages that list PDF files now also include a link to download Adobe Reader.
* Security fixes
  * When user log out of the application, their browser is also logged out of UC's central authentication.
  * HTML script tags are no longer allowed in Collection titles.
 
### 1.4.1 1/4/2016
* Created a welcome page customized for student users
* Help information is now displayed for file rollbacks
* Bug fixes
  * Users can no longer access the /login page while they are currently logged in
  * Cleaned up cascaded delegate rights for some users

### 1.3.1 12/16/2015
* Bug fixes
  * Reverted the 1.3.0 change to the My Works menu due to a software bug.

### 1.3.0 12/04/2015
* Updated text on the Welcome page and Collection Policy page
* Added new styling to the upload buttons for works, files, collection images, and profile images
* The My Works screen now only lists content that is owned by the user
* Bug fixes
  * Fixed a bug that caused search terms to be lost when selecting a facet
  * Fixed a bug that caused sort options to be lost when moving to the next page of search results
  * Fixed a bug that required users to edit and save their profile page before adding sections to their profile
  * Fixed a bug that allowed a user's delegate's delegates to edit the user's works
  * Fixed a bug that prevented the depositor of a work from being removed as an editor of the work
  * Fixed a bug that generated an error when certain types of files with Additional Status Messages were displayed

### 1.2.0 10/30/2015
* Styles upload button and help text.
* Adds slack integration to travis.
* Indexes owner field in solr.
* Adds legend tags to all fieldset tags.
* Adds image alt text to thumbnails.
* Adds name to gravatar profile pictures on profile pages.
* Adds ‘Can edit group’ label to all checkboxes.
* Creates meta tags in header for works.
* Updates Gemfile to latest Curate reference.
* Adds global lang attribute to html tag.
* Bug fixes
  * Fixes legend tags that should not be displaying.
  * Fixes Markup Errors.
  * Fixes unordered lists in Sufia locales.
  * Delegate cleanup abolishes cascading delegate relations.
  * Fixes padding on btn class.

### 1.1.0 10/16/2015
* Adds dc.identifier meta tag to Work show page so that altmetric bookmarklet and other tools will find a DOI.
* Creates administrative rake task for user/work/file manifest.
* Bug fixes
  * Adjusts modal css for creator, subject, and other facets so that next / previous buttons displays.

### 1.0.1 9/17/2015
* Bug fixes
  * Fixed problem where UIDs were being used instead of emails for users
  * Reset the application url config to a Bamboo variable

### 1.0.0 9/16/2015

### 1.0.0.rc2 9/11/2015
* Replaces ScholarStories image. 
* Fixes typo on FAQ page.
* Bug Fixes
  * Allows password resets for uc.edu when shibboleth is turned off. 
  * Fixes images on error pages. 
  * Allows new user profiles to be found on search.  
  * Resolves embargo date bug fix and blank vulnerability.  
  * Resolves shibboleth SAML2 vulnerability warning. 

### 1.0.0.rc1 8/28/2015
* Created a new user welcome page.
* Implemented UC Shibboleth authentication.
* Removed the “beta” tag.
* Removed specific work types from add new menu. The menu now takes users to a page listing all of the work types.
* Revised work type descriptions.
* Added helper text to the My Groups interface.
* Added content to the FAQ page.
* Updated the Collection policy.
* Added a new image to the home page sliders.
* Resolved several vulnerabilities/warnings reported by internal security scans.
* Bug Fixes
  * Fixed broken profile and collection avatars.
  * Fixed multiple-file upload document work type.
  * Fixed embargo bug that only released the first 10 works.

### 0.15.0 7/31/2015
* Works, files, collections, and profile pages now display a link that can be used to return to that page later.
* The URLs now better describe what type of content is being displayed (work, file, etc.)
* Made changes to menu structure
* The ETD option was removed from the New Works page (ETD's will be batch loaded)
* Bug fixes
  * Resolve password autocomplete vulnerability

### 0.14.0 7/2/2015
* The contact form now requires users to complete a CAPTCHA before sending.
* Repository manager accounts are no longer visible to other users.
* Error pages have been edited and refined.
* Users no longer have the ability to deactivate their own account.
* An alternative, shorter URL is displayed at the bottom of each work, and on the show page for each file.
* Bug fixes
  * The add-to-collection dialog box no longer requires the user to scroll their browser window.

### 0.13.0 6/22/2015
* Edits robots.txt on QA to allow accessibility scans.
* Repository Managers should see all users in People tab.
* Sends additional emails for embargo.
* Bug fixes
  * Solves problems with file titles and file upload.
  * Solves routing problem when editing user profile.

### 0.12.0 5/22/2015
* Work input forms now have a link to the Creator Rights page
* A non-discrimination notice has been added to the site's footer
* Bug fixes
  * Several security issues have been resolved

### 0.11.0 5/1/2015
* Users will now receive email notifications when an item's embaro expires.
* Added a Creator's Rights page (under the Help menu).

### 0.10.0 4/17/2015
* Users can now limit their searches by subject facet.
* Help text on the My Delegates pages has been enhanced.
* Several enhancements were made to the menu structure and layout.
* Bug fixes
  * Hyperlinks in the Distribution License have been fixed. 
  * When a work's embargo expires, the access restriction is now correctly set to "Open Access"
  * Several bugs involving delegates were resolved.

### 0.9.0 - 4/2/2015
* Update Distribution License
* Update Terms of Use

### 0.8.0 - 3/16/2015
* Redesign work input form
* Hide user profiles until the user has created content

### 0.7.0 2/27/2015
* Updated the UC menu bar
* Bug fixes
   * When an owner removes a delegate the background worker will scan the repository for any objects and attached files submitted on behalf of the owner and then remove edit access and assign the owner as primary editor.

### 0.6.0 - 1/30/2015
* The works show page now displays additional metadata fields
* Bug fixes
  * Fixed a bug with pagination introduced in v0.5.0
  * Fixed a bug with a symbol not displaying correctly in the UC menu bar

### 0.5.0 - 1/16/2015
* Exteneded keyword searching to fields other than title

### 0.4.1 - 12/12/14

* Bug fixes
  * Fixed a problem causing the site's tagline to wrap to second line in some browsers
  * Fixed a problem where works with very long names could not be removed from related works
  * Fixed a bug that made the publisher field mandatory even after the "Do not create DOI" option was selected
  * Removed duplicate and incorrect declaration of Document description
* Security fixes
  * Added a parameter check that filters out unknown parameters passed in the URL

### 0.4.0 - 12/1/14

* Added "beta" tag to site header
* Customized the 404, 422, and 500 error pages
* Bug fixes
  * Fixed various HTML validation errors
  * Rights for editors and groups are now confered correctly to files

### 0.3.0 - 11/14/14

* Updated app to use Rails 4.0.11
* Updated the app's gem dependencies
* Added scripts to monitor and kill the resque pool
* Added a robots.txt file for production server
* Added a sitemap.xml file for production server
* Bug fixes
  * Fixed the restart_resque.sh script to properly kill workers
  * Fixed a bug where thumnail images were bleeding into text

### 0.2.1 - 10/24/14

* Bug fixes
  * Only show "Add to Collection" button when user is logged in.
  * The "Clear Limits" button in the facets display now returns the user to the catalog instead of the home page.
  * Removed "A PDF is preferred" from Datasets and Generic Works forms.
  * Collection display page now correctly displays the creator next to the title.
  * The "more" link when using facets now works properly

### 0.2.0 - 10/13/14

* Change home page to link to new ScholarBlog
* Add Google Analytics tracking code
* Change format of buttons on home page carousel
* Add CHANGELOG
* Bug fixes
  * Fix links to contact form on FAQ and About Us pages
  * Tweak wording on File Format Advice page
  * Fix path to jquery0zrssfeed.min.js
  * Remove unneeded holder.js
  * Fix deavtivate account button


### 0.1.0 - 9/30/14

* Initial release

### Pre-release - 9/8/14

* Updated names of all non bootstrap ids and classes to use "uc_" prefix
* Used site-subtitle id for Research Hub message and moved search bar to same line as action buttons
* Adds Hydra icon and language to footer
* Changes to title_bar and brand_bar for UC Styling and naming.
* Adds user_root route to config.rb for login redirect.
* Creates routes, actions, and views for faq, policy, and fair_use pages.
* changes plus to add new with dropdown caret
* Update recipients_list.yml
* Update mailboxer.rb
* adds new images for three feature areas and modifies _exhibits.html.erb
* adds new slideshow images and text with view button linking to Collection Policy
* adds routes, actions, and views for extended policy and terms modifications.
* Expanded slider view and images.
* Bugfix RSS Partial
* Update overall responsiveness

### Pre-release - 8/21/14

* Installed and integrated clamav anti-virus.
* Updated branding and style to reflect UC Theme / Colors/ Responsive design.
* Added Presentation splash page, About pages, and Terms and Condition Page.
* Changed root_home to go to Presentation splash page.

### Pre-release - 6/25/14

* Fixed bug where adding an editor or creator might delete an existing person in the list

### Pre-release - 5/21/14

* Remove Embargo date when object is not embargoed.
* Resets Representative value of parent object when file is deleted.
* Updates Gemspec to work for hydra-dervivatives.
* Fixes problems with turbolinks and autocomplete.
* Tweaks how future date validation works.
* Adds multi-value presence validation.
* Fixes embargo when visibility is set via default.
* Fixes predicate_mappings.yml file path for generator.
* Handles Groups Controller error.
* Adjusts Group Membership user comparison.
* Removes conflicting Solr filters for Group.
* Fixes issue with adding editors to a generic work.
* Changes Group to rely on user_key instead of depositor.

### Pre-release - 5/2/14

* Repository manaagers can now discover and edit embargoed content.
* Contributors may be added without creating them as a user. 
* Fix vertical alignment problem between required information on left and content editors on right. 
* Fix error when a work is created with a collaborative group.
* Convert browse_everything js to coffee script for work with turbo links.
* Fix error when a new user is a repository manager and signs up for new account.
* Validate that groups have at least one editor.
* Display error message when user attempts to delete all members from a group.
* Fix error when a group member is deleted and added back in one update.
* Increase the maximum display result for groups to 50.
* Fix duplicate group label display.
* A profile section should always be open/public
* Add visual enhancements to the My groups management page.
* Do not show My Content section to unauthenticated users.
* Do not list proxies as contributers.
* Display only works and collections which have open access on profile.
* Set default access rights on works and collections to open/public.

### Pre-release - 4/9/14

* Fixed a problem where entering a password that is too short when creating an account broke the creation process.
* Fixed a problem where users would sometimes get multiple delete confirmation dialogs
* Setting content as embargoed now properly hides the content until the embargo date.
* Users designated as “repository managers” can now edit other users’ profiles.
* Users designated as “repository managers” can now discover other users’ embargoed content.
* Organizations are now functional and have been renamed “Groups"
* URL links on profile pages are now clickable.
* User profile pages have been re-designed.
* Users are now returned to the parent work after editing a file.
* When creating works, users can now add content from cloud services such as Dropbox and Google Drive (this feature is not active yet).
* Proxies have been renamed “delegates."
* Licensing terms are now displayed on a work’s page.
* Users can now add editors while creating a work.

### Pre-release - 3/12/14

* URLs in Profiles are now clickable.
* Sort options are now working with search results and browse of creators, works and collections.
* When uploading a work, auto-complete now works the on contributor fields.
* End of word match on a search. ('photograph' should retrieve photograph and photographs)
* Implemented a "soft delete" option that retains objects in Fedora after they have been deleted.  (Soft delete is currently turned OFF in CurateUC).
* Collections can now be deleted by their owner.
* The collections edit page now displays all of the objects belonging to that collection.
* Works can now be deleted by their owner.
* Specific users can now be designated as a "repository manager" giving them full rights to edit and delete any works or collections.
* Users can now create "organizations."  This feature does not yet have a function and will be renamed to "groups" in a future version.
* The user interface is now customized with UC's colors and logo (temporary).
