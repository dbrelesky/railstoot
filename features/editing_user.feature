
Feature: Editing User

	Scenario: A user edits his profile with invalid information
	Given a user visits his user edit page
	When he submits invalid profile information
	Then he should see an error message
	
	Scenario: A user edits his profile with valid information
	Given a user visits his user edit page
	And the user submits valid profile information
	Then he should see a success message