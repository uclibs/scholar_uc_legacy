Deleting a profile section from your own profile page does not work.  Clicking the "Remove" button gives a double confirmation box and then leaves the profile section in place. 
* Bug logged at https://github.com/uclibs/curate_uc/issues/72
* **Comment from Linda -- I've verified this on our implementation of Curate on our sandbox.  This is new behavior.  It is not the behavior on curatevanilla.library.nd.edu which is today still at build 2014-05-05.  So our tests didn't discover when we broke this, but we should try to find that and fix.**

***

Deleting a work from a collection does not work.  Clicking the "Remove" button gives a double confirmation box and then leaves the work attached to the collection.  
* Bug logged at https://github.com/uclibs/curate_uc/issues/71
* **From Linda:  Also verified on our sandbox, and also new behavior, and also not the behavior on curatevanilla.  We should fix.**

***

When viewing your own work, the buttons at the bottom of the page only display a folder icon for "Add Generic Work to Collection"  There is no text to tell the user what the button does.

***

When you try to create a work with a Word (*.doc) document or try to attach a .doc to an existing work, the user gets a "400 Bad Request" error.  However, the work and file are created properly.  This seems to be specific to .doc files for some reason.

***

The icon to remove a delegate is all white with no background.  So it is impossible to see against a white background. 
* Bug logged in comments at https://github.com/uclibs/curate_uc/issues/17
* **From Linda: I believe this may date from work done a few months ago to change buttons from the Blue that is the default in Curate, to Black (and some became White and therefore hidden?).  We have not had discussion about whether we want this color to be Black or something else (for buttons below the header -- for now I recommend we stick with the red buttons in the site-actions bar).  We should make that decision and revisit these changes, making sure that none of the buttons remain hidden.**

***

Delegate account can still edit another user’s work after being removed as a delegate
* Bug logged at https://github.com/uclibs/curate_uc/issues/54

***

If I am added as an editor of another user's work, I am still not able to edit/delete the existing attached files of that work.

***

If a repository manager attaches a new file to another user's work, the owner of that work cannot edit/delete the attached file.