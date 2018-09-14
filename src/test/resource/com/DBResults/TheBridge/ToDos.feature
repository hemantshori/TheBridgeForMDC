Feature: These are todos

@wip
  Scenario Outline: TB-11:As an Admin, I want to add/edit a Participant so that I can monitor their progress within the Bridge
    # Email address not in a valid format
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <Password1>  |
    And I wait for "1000" milliseconds
    # And I hit Enter
    And I click on button with value "Login"
    And I wait for "1000" milliseconds
    Then I check I am on "Activities" page
    And I wait for "1000" milliseconds
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I wait for "1000" milliseconds
    Then I click on text "Admin"
    Then I see text "Participants" displayed
    Then I click on text "Participants"
    # Then I click on text "ParticipantCreate"
    Then I click on button with value "Create"
    And I check I am on "ParticipantDetail" page
    
      
    
    Then I select option "Female" from "Gender"
    And I select option "1991" from "YearJoined"
    And I enter the details as
      | Fields           | Value            |
      | FirstName        | Cherry1          |
      | LastName         | Pie              |
      | DateEnteredInput | 2018-03-19       |
      | DateEndedInput   | 2018-03-26       |
      | Phone            | +6190002000      |
      | Mobile           |       0423234022 |
      | Email            | pie@cherrie1.com |
      | Coach            | Gol Gappa        |
      | auto            | Retrain        |
      And I hit Enter
    And I select option "25 - <35" from "AgeRange"
    And I select option "4" from "GroupLevel"
    And I select option "Melbourne, VIC" from "Location"
    Then I click on text "Duplication"
    Then I click on text "Acme Holdings LImited"
    Then I click on text "Skills Australia"
    Then I click on text "The Bridge"
    Then I click on text "Workshops 101"
    Then I click on text "Upskill Australia"
    Then I click on text "Field Validation Co"
    And I click on button with value "Save"
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName                                |
      | item2 | Email address must be in a valid format |

    Examples: 
      | PortalName | EmailAdmin   | Password1 |
      | Bridge     | portaladmin1 | password1 |
