@wip
Feature: Wip

  Scenario Outline: TB-10: As a Participant/Supplier/Admin, I want to login to the system so that I can access the portal features
    # Scenario 0: User enters valid username and password
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email>     |
      | PasswordInput | <Password1> |
    And I wait for "1000" milliseconds
    And I hit Enter
    And I wait for "1000" milliseconds
    Then I check I am on "Activities" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    Then I click on button "Logout"
    And I wait for "2000" milliseconds
    And I check I am on "Logout" page
    # Scenario 1: Mandatory fields not filled in
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value   |
      | UserNameInput | <Email> |
    And I hit Enter
    Then I see text "Required fields have not been completed." displayed
    # Scenario 2: User enters Invalid Credentials
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email>     |
      | PasswordInput | <Password2> |
    And I hit Enter
    Then I see text "Invalid username or password" displayed
    # Scenario 3: User enters valid username and password
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email>     |
      | PasswordInput | <Password1> |
    And I wait for "2000" milliseconds
    And I hit Enter
    Then I check I am on "<SomePage>" page
    Then I see text "HI" displayed
    Then I click on text "<some text>"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item4  | <item3> |
      | item5  | <item4> |

    Examples: 
      | PortalName | Email                         | Password1 | Password2 | SomePage   | some text      | item1                                                     | item2         | item3    | item4            |
      | Bridge     | hemant.shori@dbresults.com.au | Support#1 | Crap      | Activities | All Activities | Activity Date                                             | Activity Name | Supplier | Available spaces |
      | Bridge     | part1@dbresults.com.au        | password1 | Crap      | Activities | All Activities | Activity Date                                             | Activity Name | Supplier | Available spaces |
      | Bridge     | ac1@dbresults.com.au          | password1 | Crap      | Activities |                | This page is under construction. Please check back later. |               |          |                  |

  @wip
  Scenario Outline: TB-10: As a Participant/Supplier/Admin, I want to login to the system so that I can access the portal features
    # Scenario 0: User enters valid username and password
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email>     |
      | PasswordInput | <Password1> |
    And I wait for "1000" milliseconds
    And I hit Enter
    And I wait for "1000" milliseconds
    Then I see text "You no longer have access to the system. Please contact your Coach to discuss further" displayed

    Examples: 
      | PortalName | Email             | Password1 | 
      | Bridge     | enddate1@test.com | password1 | 
