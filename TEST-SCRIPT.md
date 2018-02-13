These tasks are usually performed on http://scholar-qa.uc.edu after a deployment.

### Users
* Repository Manager = manager@example.com
* Student Delegate = delegate@example.com
* Professor Nodeposits = nodeposits@example.com
* Professor Manydeposits = manydeposits@example.com

### Create Article
1. Log in as self
1. Create article with private access controls
1. describe using every field
1. add a pdf that is public
1. add a word doc that is private
1. add an image that is public
1. verify it works as expected
1. change article access controls to public - allow the system to change privacy on attached works
1. verify it works as expected

### Edit Article
1. Edit the article
1. Upload another file
1. Save article
1. Edit the article
1. Remove the first file
1. Save article

### View Article
1. Add to Collection
1. Add External Link
1. Update Related Works
1. Delete Work

### Create Collection and Share
1. Log in as self
1. Create a collection 
1. Add a title, description, image
1. Set access control to Your institution 
1. Create another collection
1. Add a title, description, image
1. Set access control to Public
1. Create another collection
1. Add a title and description
1. Set access control to private
1. Add at least 10 items to each collections, a mix of your own content and others
1. Log out 
1. Verify you can discover the publically accessible but not the other two
1. Verify that the items are listed alphabetically.
1. Login as Professor Nodeposits
1. Verify you can discover the publically accessible, the Your institution but not the private
1. Log in as self
1. Verify you can discover all three
1. Navigate to one of your collections
1. Edit the access controls
1. Verify access controls
1. Delete several items from the collection
1. Delete a collection
1. Verify collection is not listed

### Profile Curation
1. Log in as self
1. Change your profile picture
1. Add a highlighted work to your profile
1. Remove the highlighted work from your profile

### Proxy
1. Add "Professor Manydeposits" as a proxy to your account: 
1. Log in as Professor Manydeposits
1. Add a work as Manydeposits
1. Make sure the Author field is listed as Manydeposits, Professor.
1. Add "Student Delegate" as a proxy to Professor Manydeposit's account
1. Log in as Student Delegate
1. Verify you can edit Professor Manydeposits' work
1. Student Delegate should NOT be able to edit _your_ work
1. As Student Delegate - Add work on behalf of Manydeposits
1. Log in as Manydeposits
1. Verify the work is listed under your works
1. Verify Manydeposits is listed as a contributor
1. Edit the work, add a file
1. Remove Student Delegate from your proxies
1. Log in as Student Delegate
1. Verify Student Delegate does not have access to Manydeposit's work (BUG #56)
1. Verify Student Delegate does not have access to your work (BUG #499)
1. Log in as yourself
1. Remove Professor Manydeposits from your proxies

### Collaborate on Private Work
1. Log in as Professor Manydeposits
1. Create a private work with many files attached
1. Add Professor Nodeposits as an editor
1. Log in as Professor Nodeposits
1. Navigate to the work just created
1. Edit metadata
1. Replace an existing file
1. Add relationships
1. Grant a group edit rights
1. Grant a group edit rights that does not exist in the system

### Repository Manager
1. Log in as Repository Manager
1. Verify you see an edit button on results in the index view
1. Choose a work to edit that is not your own
1. Edit description of that work
1. Verify the edits persist
1. Change the access control settings to private
1. Verify you can still access a private item
1. Edit the item/change the access control settings back
1. Add yourself (not repo manager, but your acct) as an editor to work
1. Log in as yourself
1. Navigate to the item in link 14
1. Verify you can access/edit the item
1. Log in as Repository Manager
1. Navigate to a collection that is not owned by you
1. Edit the collection description and access control settings
1. Verify the edits persist
1. Navigate to a work that is not owned by Repository Manager
1. Add a new file
1. Delete a previous file
1. Verify changes persist

### Search and Discovery
1. Test next and previous page buttons in search results
1. Verify works and collections that are open access are discoverable via search and browse while logged out
1. Verify works and collections that are not your own "Your institution" are discoverable via search and browse while logged in.
1. Verify works and collections that have "Your institution" access rights are NOT discoverable via search or browse while logged out.
1. Verify that works and collections that are not your own, but are marked as private are not discoverable via search or browse when you are logged in
1. Verify that works and collections that are marked as private are not discoverable via search or browse when you are logged out.
1. Verify that profile sections do not show up in search results
1. Run a search that returns more than 1 work. Verify that selecting a facet does not cause your initial search to be lost. (Do this both logged in and logged out)
1. Browse by Works and change the sort option to something other than relevance. Verify that the sort option is retained when you page forward or back. (Do this both logged in and logged out)

### Design and Layout
1. Check for changes in the UC (black) menu bar
1. Re-size browser window to test responsiveness 
1. Test different browsers and platforms (Chrome, Firefox, IE, Android, iOS, etc.)
