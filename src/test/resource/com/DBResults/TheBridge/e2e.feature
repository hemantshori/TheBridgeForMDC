
Feature: these are e2e for Randstad project.

  Scenario Outline: TE2E, activity created in todays date and enroled
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
         And I select option "Explore" from "Stage"
    # And I select option "5" from "Activity_MaxParticipants"
    And I enter the details as
      | Fields                   | Value |
      | Activity_MaxParticipants |     5 |
    And I enter "12-05-2018" with the current date prepended into "Activity_ActivityDate"
    And I hit Enter
    And I enter the details as
      | Fields        | Value        |
      | Activity_Name | <searchWord> |
    And I select "Find a new role" from "Career"
    And I select "Retrain" from "Career"
    And I select "Start a business" from "Career"
    Then I click on button with value "Save"
    And I wait for "2000" milliseconds
    Then I see text "Activity successfully created" displayed
    #Scenario 2: An Admin user Edits an Activity with no Participants enrolled
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item4  | <item3> |
    #| item5  | <item4> |
    #And I "click" row "2" of table "Main"
    #And I wait for "1000" milliseconds
    #And I check I am on "ActivityDetail" page
    #Scenario 1:
    #And I click on button with value "Cancel"
    # TB-50: As a Supplier, I want to be able to view a list of my Activities so that I can track my Activities
    And I click on text "All Activities"
    # TB-53: As a Supplier I want to search for one of my Activities so that I can quickly find the Activity I need
    Then I click on button "Search"
    And I wait for "1000" milliseconds
    Then I check "SearchKeywordInput" exists
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <searchWord> |
    And I hit Enter
    And I wait for "1000" milliseconds
    #And I click on text "<searchWord>"
    And I "click" row "1" of table "Main"
    And I click on button with value "Cancel"
    And I check I am on "Activities" page
    Then I click on button "Search"
    #And I wait for "1000" milliseconds
    #Then I check "<searchWord>" exists
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <searchWord> |
    And I hit Enter
    And I wait for "1000" milliseconds
    #And I click on text "<searchWord>"
    And I "click" row "1" of table "Main"
    And I check I am on "ActivityInfo" page
    #Then I check "Supplier" is readonly
    #Then I check "Activity" is readonly
    #Then I check "NAB" is readonly
    And I wait for "1000" milliseconds
    Then I click on button "Logout"
    # Scenario: Login as bc3 and enrol into above activity
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email2>    |
      | PasswordInput | <Password2> |
    And I click on button with value "Login"
    And I check I am on "Activities" page
    Then I click on text "All Activities"
    Then I click on button "Search"
    And I wait for "1000" milliseconds
    Then I check "SearchKeywordInput" exists
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <searchWord> |
    And I hit Enter
    And I wait for "1000" milliseconds
    # And I click on text "<searchWord>"
    And I "click" row "1" of table "Main"
    And I click on button with value "Enrol"
    And I wait for "1000" milliseconds
    Then I see text "You have successfully enrolled in this Activity." displayed
    #ensure no longer available
    Then I see text "No activities to show" displayed

    Examples: 
      | PortalName | Email                         | Password   | item1 | item2    | item3    | item4      | searchWord | Email2               | Password2 |
      | Bridge     | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Date  | Activity | Supplier | Enrolments | someautoDNT    | bc3@dbresults.com.au | password1 |
  Scenario Outline: This is e2, activity generated IN TOMORROWS DATE>verified>edited>cancelled
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
    And I click on button with value "Create"
    And I check I am on "ActivityDetail" page
    Then I select option "BC3 Auto Co" from "Activity_SupplierId"
    And I select option "Melbourne, VIC" from "Activity_LocationId"
    And I enter a application specific time in "EndHour"
         And I select option "Explore" from "Stage"
    And I enter the details as
      | Fields                   | Value |
      | Activity_MaxParticipants |     5 |
    And I enter "<dateforIT3>" date as a "future" date in "Activity_ActivityDate"
    And I hit Enter
    And I enter the details as
      | Fields        | Value        |
      | Activity_Name | <searchWord> |
    And I select "Find a new role" from "Career"
    And I select "Retrain" from "Career"
    And I select "Start a business" from "Career"
    Then I click on button with value "Save"
    And I wait for "2000" milliseconds
    Then I see text "Activity successfully created" displayed
    Then I click on button "Logout"
    #loggin as bc3
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email2>    |
      | PasswordInput | <Password2> |
    And I click on button with value "Login"
    And I check I am on "Activities" page
    And I check I am on "Activities" page
    Then I click on text "All Activities"
    Then I click on button "Search"
    And I wait for "1000" milliseconds
    Then I check "SearchKeywordInput" exists
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <searchWord> |
    And I hit Enter
    And I wait for "1000" milliseconds
    # And I click on text "<searchWord>"
    And I "click" row "1" of table "Main"
    And I click on button with value "Enrol"
    And I wait for "1000" milliseconds
    Then I see text "You have successfully enrolled in this Activity." displayed
    Then I click on button "Logout"
    #loggin as admin
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <Email>    |
      | PasswordInput | <Password> |
    And I click on button with value "Login"
    And I check I am on "Activities" page
    Then I click on button "Search"
    Then I check "SearchKeywordInput" exists
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <searchWord> |
    And I hit Enter
    And I wait for "1000" milliseconds
    # And I click on text "<searchWord>"
    And I "click" row "1" of table "Main"
    And I check I am on "ActivityDetail" page
    And I enter the details as
      | Fields      | Value         |
      | Description | <Description> |
    And I click on button with value "Save"
    Then I click on button "Search"
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <searchWord> |
    Then I click on button with value "Search"
    And I "click" row "1" of table "Main"
    Then I see text "<Description>" displayed
    #Verify Cancel activity (Only for announced status)
    Then I click on button with value "Cancel Activity"
    Then I switch to frame "0"
    Then I click on button with value "Yes"
    And I see text "Cancellation Reason" displayed
    Then I click on button with value "Cancel"
    And I wait for "3000" milliseconds
    Then I click on button with value "Cancel Activity"
    And I wait for "5000" milliseconds
    Then I switch to frame "0"
    Then I click on button with value "Yes"
    And I wait for "1000" milliseconds
    Then I click on button with value "Save"
    And I see text "Required field!" displayed
    And I enter the details as
      | Fields            | Value      |
      | CancelReasonInput | Meri marji |
    Then I click on button with value "Save"
    And I wait for "1000" milliseconds
    And I see text "Successfully Cancelled" displayed

    Examples: 
      | PortalName | Email                         | Password   | dateforIT3 | item2    | item3    | item4      | searchWord | Email2               | Password2 | Description            |
      | Bridge     | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Date       | Activity | Supplier | Enrolments | SixautoDNT | bc3@dbresults.com.au | password1 | This is automated test |

      
      
       Scenario Outline: TB-21 As an Admin, I want to add/edit a Supplier so that they can can login to the portal -- supplier e2e
    # Scenario 1: User's session has been inactive
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <Password>   |
    And I click on button with value "Login"
    And I check I am on "Activities" page
    #Scenario 1: Admin selects Create Supplier function
    And I click on text "Admin"
    And I wait for "1000" milliseconds
    And I click on text "Suppliers"
    And I check I am on "Suppliers" page
    When I click on button with value "Create"
    Then I check I am on "New Supplier" page
    And I enter the details as
      | Fields        | Value                  |
      | Supplier_Name | <SomeSupplierName>     |
      | ABN           | <ABN>                  |
      | Address       | automated test address |
    When I click on button with value "Save"
    #Scenario 5: Mandatory fields not filled in
    Then I see text "Mandatory fields must be filled in" displayed
    And I click on button with value "Cancel"
    And I check I am on "Suppliers" page
    When I click on button with value "Create"
    Then I check I am on "New Supplier" page
    #Scenario 2: Email address not in a valid format
    And I enter the details as
      | Fields    | Value          |
      | FirstName | automated test |
      | Mobile    |     0200200022 |
      | LastName  | Trump          |
      | Email     | Tru      mpWTF |
    When I click on button with value "Save"
    Then I see text "Email address must be in a valid format" displayed
    And I click on button with value "Cancel"
    #Scenario 6: Admin creates Supplier
    And I check I am on "Suppliers" page
    When I click on button with value "Create"
    Then I check I am on "New Supplier" page
    And I enter the details as
      | Fields        | Value                  |
      | Supplier_Name | <SomeSupplierName>     |
      | ABN           | <ABN>                  |
      | Address       | automated test address |
      | FirstName     | some automated test    |
      | Mobile        |             0200200022 |
      | LastName      | Trump                  |
      | Email         | a@db.com               |
    And I capture text "Supplier_Name"
    #Scenario 4: ABN already exists
    When I click on button with value "Save"
    #Scenario 6: Admin creates Supplier
    Then I see text "Supplier record successfully created" displayed
    #Scenario 7: Admin edits /delete Supplier with mandatory fields
    Then I click on button "Search"
    And I wait for "1000" milliseconds
    Then I check "SearchKeywordInput" exists
    And I wait for "1000" milliseconds
    #And I enter the details as
      #| Fields             | Value              |
      #| SearchKeywordInput | <SomeSupplierName> |
    And I paste "Supplier_Name" value in "SearchKeywordInput"
    And I hit Enter
       # disabled because of bug
   # And I "click" row "1" of table "Main"
 
    #When I click on button with value "Deactivate"
    #Then I switch to frame "0"
    #Then I click on button with value "Yes"
    #Then I see text "Supplier record successfully deactivated" displayed

    Examples: 
      | PortalName | EmailAdmin                    | Password   | ABN         | SomeSupplierName |
      | Bridge     | wenzil.admin@dbresults.com.au | WOsdrdoTlO | 22332131231 | autotest        |
      
      