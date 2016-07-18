Backlog Grooming, Story Triage, and Sprint Planning
This is how work gets prepared for upcoming sprints:

1.	PO or anyone else adds stories to the backlog. PO grooms the backlog so at least there are a base set of stories to triage. PO prioritizes and massages the stories, focusing on their vision of user interactions with the product.
2.	Story Triage is performed:
a.	PO, Tech Lead, and anyone else they feel they need to bring into the process (but fewer is better) should perform Story Triage.
b.	This group meets sometime before the next Sprint Planning.
c.	Story Triage team adds requirements to the stories in the backlog, including acceptance (“Done”) criteria. This team also discusses breaking the story up into more stories, and does so if necessary.
3.	During Sprint Planning
a.	Team reviews and sizes stories based on effort (the number of days they think it will take). 1 point = 1 work day (roughly 6 hours).
b.	If the story is sized above 5, or if the team feels they need to break the work down, the story should be broken down into smaller chunks.
c.	Team decides how much they can do in the next sprint. PO decides which stories will be worked on in the next sprint.


The Sprint Work Process
This is how work gets tracked and completed during sprints. Each column represents different stage in the process. As each stage gets completed, the team should move the Story card to the next column on the board.
Overview of the work stages
Queue	TCC	Dev	QA	Done
Story H
Story I
Story J	Story D
Story E
Story F	Story C
BLOCKED - Story G	Story B	Story A

Queue -- Stories in the queue that the team will work on for this sprint
TCC -- Test Case Creation for each one of the stories. QA, developers, and product owner (and possibly subject matter experts) will come up with automated and manual test criteria (including writing Cucumber/other functional automated tests). No code is written.
Example Cucumber tests:
Given I am on the preview page
When I upload the EAD XML file
Then it should display the preview of that EAD XML file

Given I am on the preview page
When I upload the a non XML file
Then it should display "Not an XML File" error message

Dev -- Developers will write code against the test cases. QA also writes manual/Selenium tests for any UI components. Code is merged into Github and deployed to integration server.
If there are needs to add or modify test cases, then the Developers should talk with the QA (and possibly product owner). No need to move the story back to the TCC step.
QA -- QA person (and anyone else available to test) manually tests the functionality of the newly deployed features, and any necessary regression tests.
If a test fails, QA/test person will talk with developer and double-check. Developer will fix if it’s a code problem. Move the story back to the Dev step if the Developer feels necessary.
Done -- Code is deployed to Vanilla Curate, all tests pass, and product owners have signed off on the feature.
Blocked -- When a story is blocked from being worked on for whatever reason the word “BLOCKED - “ can be placed in the name of story. It is the team’s discretion to flag the story as BLOCKED based on their assessment of the level of blockage.

Columns can be added, removed, or renamed as the team sees fit in the future.
