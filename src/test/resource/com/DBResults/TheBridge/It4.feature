Feature: Iteration 4 stories

  @wip
  Scenario Outline: TB-333 As an Admin, I want to assign a Stage to an Activity so that it aligns to the Program status of a Participant
    # Scenario 1: An Admin user views the list of Activities – screen behavior
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <Email>    |
      | PasswordInput | <Password> |
    And I click on button with value "Login"
    And I wait for "1000" milliseconds
    And I check I am on "Activities" page
    And I wait for "1000" milliseconds
    # Auto test pre condition create an activity with no participant
    And I click on button with value "Create"
    And I check I am on "ActivityDetail" page
    Then I select option "BC3 Auto Co" from "Activity_SupplierId"
    And I select option "Melbourne, VIC" from "Activity_LocationId"
    And I wait for "1000" milliseconds
    And I enter a application specific time in "EndHour"
    And I enter the details as
      | Fields                   | Value |
      | Activity_MaxParticipants |     5 |
    And I enter "30-07-2018" with the current date prepended into "Activity_ActivityDate"
    And I hit Enter
    And I enter the details as
      | Fields        | Value        |
      | Activity_Name | <searchWord> |
    And I capture text "Activity_Name"
    And I select "Find a new role" from "Career"
    And I select "Retrain" from "Career"
    And I select "Start a business" from "Career"
    Then I click on button with value "Save"
    And I wait for "1000" milliseconds
    #Scenario 1: Admin creates a new Activity
    Then I see text "Mandatory fields must" displayed
    And I select option "Explore" from "Stage"
    Then I click on button with value "Save"
    And I wait for "2000" milliseconds
    Then I see text "Activity successfully created" displayed
    # Scenario 2,3,4: Admin edits an existing Activity and check stage is editable
    Then I click on button "Search"
    And I paste "Activity_Name" value in "SearchKeywordInput"
    And I hit Enter
    And I "click" row "1" of table "Main"
    And I wait for "2000" milliseconds
    And I select option "Plan and Create" from "Stage"
    Then I click on button with value "Save"
    And I wait for "2000" milliseconds
    Then I see text "Activity successfully created" displayed

    Examples: 
      | PortalName | Email                         | Password   | item1 | item2    | item3    | item4      | searchWord    | Email2               | Password2 |
      | Bridge     | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Date  | Activity | Supplier | Enrolments | autoItfourDNT | bc3@dbresults.com.au | password1 |
