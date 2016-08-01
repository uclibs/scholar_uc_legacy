### Users
* Repository Manager = manager@example.com
* Student Delegate = delegate@example.com
* Professor Nodeposits = nodeposits@example.com
* Professor Manydeposits = manydeposits@example.com

### Create Article
1. Log in as self
1. Create article
1. describe using every field except DOI
1. add a pdf that is public
1. add a word doc that is private
    * [Expecting thumbnail](https://scholar-dev.uc.edu/works/files/p5547r677)
1. add an image that is public
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
    * Typo in URL for colleciton "//"
1. Add External Link
1. Update Related Works
    * Works, but it's odd that this is a different UI than delegates
1. Delete Work
    * Deleted the related work - causes an [issue](https://scholar-dev.uc.edu/works/generic_works/p5547r71t)
    * Unable to replicate - Lukas

### Create Collection and Share
1. log in as self
1. create a collection 
1. add a title, description, image
1. set access control to Your institution 
1. create another collection
1. add a title, description, image
1. set access control to Public
1. create another collection
1. add a title, description, image
1. set access control to private
1. add at least 10 items to each collections, a mix of your own content and others
    * Why does the search sort order change when you do this?
    * How are collections ordered?
1. log out 
1. verify you can discover the publically accessible but not the other two
1. login as Professor Nodeposits
1. verify you can discover the publically accessible, the Your institution but not the private
1. log in as self
1. verify you can discover all three
1. navigate to one of your collections
1. edit the access controls
1. verify access controls
1. delete several items from the collection
1. delete a collection
1. verify collection is not listed

### Profile Curation
1. Log in as self
1. Change your profile picture
1. Add three URLs to your blog field
    * Not immediately how to do this - this field should support multi-add, like other multi value fields
1. Add 3 profile sections
1. add content to your profile
    * Field content is lost when password is incorrect
1. add 1 private collection and work to a profile section
1. verify it is not viewable when logged out
1. add 1 "your institution" work and collection to a profile section
1. verify it is not accessible when logged out
1. add 1 "public" work and collection to a profile section
    * It is difficult to tell which edit and delete buttons go with which works/collections/sections
1. verify it is accessible when logged out
1. Delete content from your profile
    * what does this mean?
1. Edit a profile section
    * After you do this, you land at the collection page, rather than the profile page
1. Add a long description to a section
    * What's the expected behavior?
    * After you do this, you land at the collection page, rather than the profile page
1. Remove a profile section
    * After you do this, you land at the collection page, rather than the profile page

### Proxy
1. Add "Student Delegate" to your account: 
1. Log in as Student Delegate
1. As Student Delegate - Add work on behalf of yourself
1. Log in as yourself
1. Verify the work is listed under your works
1. Verify you are listed as a contributor
1. Edit the work, add a file
1. Remove Student Delegate from your account
1. Log in as Student Delegate
1. Verify Student Delegate does not have access to your work (BUG #56)

### Embargo
1. Log in as self
1. create a work set for embargo release tomorrow
1. copy the URL for the work
1. log out. 
1. verify you can not access the work via URL
1. verify you can not access the work by searching for title
1. Log in as Professor Nodeposits
1. Verify Professor Nodeposits can not view the work
1. leave the test and come back tomorrow
    * #Ping
1. Make sure you are logged out of curate
1. verify you can navigate to the work via url
1. verify you can navigate to the work via search
1. verify the status of the work says "Open Access"

    * Edited an embargoed work - was asked to confirm file permission changes, even though only file was embargoed

### Collaborate on Private Work
1. log in as Professor Manydeposits
1. Create a private work with many files attached
1. Add Professor Nodeposits as an Editor
1. log in as Professor Nodeposits
1. Navigate to the work just created
    * Some thumbnails not rendering for Nodeposits - because they are private? problem resolved after deleting a file - Open issue?
1. edit metadata
1. replace an existing file
1. add relationships
    * related works?
1. grant a group edit rights
1. grant a group edit rights that does not exist in the system

### Relate Works to Other Works
1. log in as self
1. navigate to your works
1. create relationships to multiple works (5+)
1. verify the relationships are displayed
1. delete more than one relationship
1. verify the relationships are destroyed

### Repository Manager
1. log in as Repository Manager
1. verify you see an edit button on results in the index view
1. choose a work to edit that is not your own
1. edit description of that work
1. verify the edits persist
1. change the access control settings to private
1. verify you can still access a private item
j. edit the item/change the access control settings back
1. Add yourself (not repo manager, but your acct) as an editor to work
1. log in as yourself
1. navigate to the item in link 14
1. verify you can access/edit the item
1. log in as Repository Manager
1. navigate to a collection that is not owned by you
1. edit the collection description and access control settings
1. verify the edits persist
1. navigate to a work that is not owned by Repository Manager
1. Add a new file
1. Delete a previous file
1. Verify changes persist

### Groups
1. Log in as self
1. create a group
1. add Professor Manydeposits as an editor
1. add Student Delegate as a member
1. log in as Professor Manydeposits
1. verify you can edit group
1. log in as Student Delegate
1. Verify you can see but not edit group
1. Log in as self
1. Add group to edit rights of a work
1. log in as Professor Manydeposits
1. verify you can edit work
1. log in as self
1. Delete group
1. log in as Professor Manydeposits
1. verify you can NOT edit work
1. Add another group which is the same name as another group that you know exists in the system

### Search and Discovery
1. Test next and previous page buttons in search results
1. Verify works and collections that are open access are discoverable via search and browse while logged out
1. Verify works and collections that are not your own "Your institution" are discoverable via search and browse while logged in.
1. Verify works and collections that have "Your institution" access rights are NOT discoverable via search or browse while logged out.
1. Verify that works and collections that are not your own, but are marked as private are not discoverable via search or browse when you are logged in
1. Verify that works and collections that are marked as private are not discoverable via search or browse when you are logged out.
1. Verify that profile sections do not show up in search results

### Browse Everything
    * Dropbox gives the following error "This app has reached its user limit. Contact the app developer and ask them to use the Dropbox API App Console to increase their app's user limit."
    * Google drive works fine
1. log in
1. create a new article
1. fill in metadata
1. add a file via browse everything
1. verify you can see 

### Design and Layout
1. Check for changes in the UC (black) menu bar
1. Re-size browser window to test responsiveness 
1. Test different browsers and platforms (Chrome, Firefox, IE, Android, iOS, etc.)
1. Test the home page slider