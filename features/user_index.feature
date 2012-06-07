
Feature: User Index Page

	Scenario: A user visits the user index page
	Given the user has an account
	And the user submits valid signin information
	When he visits the user index page
	Then he should see a list of users
	And the page should have a proper title
	And the page should have a proper page heading
