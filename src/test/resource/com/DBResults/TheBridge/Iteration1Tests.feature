
Feature: Iteration1Tests
@iteration1testcasees
  Scenario Outline: TB-9:As a Participant/Supplier/Admin, I want to log out of the portal so that it prevents unauthorised access when I no longer need to use the portal
    # Scenario 1: Participitant User logs out of the portal
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value          |
      | UserNameInput | <EmailPart>    |
      | PasswordInput | <PasswordPart> |
    And I click on button with value "Login"
    And I wait for "1000" milliseconds
    Then I check I am on "Activities" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I wait for "1000" milliseconds
    Then I see text "All Activities" displayed
    And I wait for "1000" milliseconds
    Then I click on button "Logout"
    And I wait for "1000" milliseconds
    And I check I am on "Logout" page
    Then I see text "THANKS FOR USING THE BRIDGE" displayed
    Then I click on button with value "Login Again"

    Examples: 
      | PortalName | EmailPart              | PasswordPart | EmailSup             | PasswordSup |
      | Bridge     | part1@dbresults.com.au | password1    | ac1@dbresults.com.au | password1   |
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
    Then I click on button "wt9_wtHeader_loginInfo_wtLogoutButton"
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
      | Bridge     | hemant.shori@dbresults.com.au | Support#1 | Crap      | Activities | All Activities | Activity Date                                             | Activity Name | Supplier | Available Spaces |
      | Bridge     | part1@dbresults.com.au        | password1 | Crap      | Activities | All Activities | Activity Date                                             | Activity Name | Supplier | Available Spaces |
      | Bridge     | ac1@dbresults.com.au          | password1 | Crap      | Activities |                |This page is under construction. Please check back again later. |               |          |                  |

  Scenario Outline: TP-68 As an Admin, I want to view a list of Suppliers so that I know which Suppliers have access to the portal
    # Scenario 1: User's session has been inactive
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <EmailPart> |
      | PasswordInput | <Password>  |
    And I click on button with value "Login"
    Then I see text "WELCOME TO THE BRIDGE" displayed
    Then I click on text "Admin"
    Then I click on text "Suppliers"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item4  | <item3> |
      | item5  | <item4> |
    And I click on text "<item1>"
    And I verify sorting is working for "Main" table column "1"
    And I wait for "1000" milliseconds
    And I click on text "<item2>"
    And I verify sorting is working for "Main" table column "2"
    And I wait for "1000" milliseconds
    And I click on text "<item3>"
    And I verify sorting is working for "Main" table column "3"

    Examples: 
      | PortalName | EmailPart    | Password  | item1   | item2      | item3         | item4 |
      | Bridge     | portaladmin1 | password1 | Company | First Name | Mobile Number | Email |
@bug
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
    Then I click on button "wt9_wtHeader_loginInfo_wtLogoutButton"
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
      | Bridge     | hemant.shori@dbresults.com.au | Support#1 | Crap      | Activities | All Activities | Activity Date                                             | Activity Name | Supplier | Available Spaces |
      | Bridge     | part1@dbresults.com.au        | password1 | Crap      | Activities | All Activities | Activity Date                                             | Activity Name | Supplier | Available Spaces |
      | Bridge     | ac1@dbresults.com.au          | password1 | Crap      | Activities |                |This page is under construction. Please check back again later. |               |          |                  |

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


  Scenario Outline: TB-22:As an Admin, I want to search for a Participant so that I can quickly find the Participant I need
    # Scenario 1:The search field is displayed when an Admin user clicks on the search icon
    Given I want to login to portal "<PortalName>"
    And I wait for "1000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <Email>    |
      | PasswordInput | <Password> |
    And I hit Enter
    Then I click on text "Admin"
    Then I click on text "Participants"
    Then I click on button "Search"
    And I wait for "1000" milliseconds
    Then I check "SearchKeywordInput" exists
    # Scenario 2:An Admin user searches for Participants using an existing First Name or Last Name
    And I wait for "1000" milliseconds
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <searchWord> |
    And I hit Enter
    Then "<Item>" is displayed as "<ItemName>"
      | Item  | ItemName   |
      | item1 | Last Name  |
      | item2 | First Name |
      | item3 | Email      |
      | item4 | Status     |
    Then I "check" text "Pie" displayed in table "ParticipantTable"
    Then I check that table "ParticipantTable" with row containing "<searchWord>" returns atleast "1" row
    # Scenario 3: An Admin user searches for Participants using a First or Last Name that does not exist
    Then I click on button "Reset"
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <SearchNone> |
      
      
    And I hit Enter
    Then I see text "No results found." displayed

    Examples: 
      | PortalName | Email        | Password  | searchWord | SearchNone |
      | Bridge     | portaladmin1 | password1 | Cherry     | bandit     |


@todo
  Scenario Outline: TB-82 As an Admin, I want to view a list of Participants so that I know who has been registered in the portal
    # Scenario 1: User's session has been inactive
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <Password>   |
    And I click on button with value "Login"
    Then I click on text "Admin"
    Then I click on text "Participants"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item4  | <item3> |
      | item5  | <item4> |
    And I click on text "<item1>"
    And I verify sorting is working for "Main" table column "1"
    And I wait for "1000" milliseconds
    And I click on text "<item2>"
    And I verify sorting is working for "Main" table column "2"
    And I wait for "1000" milliseconds
    And I click on text "<item3>"
    And I verify sorting is working for "Main" table column "3"
    #Scenario :2 - An Admin user clicks on a participant to view the user record
    #following is a workaround till the fix comes for clicking on full name than surname
    #And I "click" row "3" of table "Main"
    And I wait for "1000" milliseconds
    And I click on text "TestTestTest*"
    And I check I am on "ParticipantDetail" page
    #Todo Add pagination check when number of participants exceed 50
    #Lets add creating Participant
     And I wait for "20000" milliseconds
    And I click on button with value "Cancel"
    And I check I am on "ParticipantList" page
    And I wait for "1000" milliseconds
    And I click on button with value "Create"
    And I check I am on "ParticipantDetail" page
    Then I select option "Female" from "Gender"
    And I select option "1991" from "YearJoined"
    And I enter the details as
      | Fields    | Value          |
      | FirstName | Some           |
      | LastName  | automatedtest  |
      #| DateEnteredInput | 12-12-2000     |
      #| DateEndedInput   | 12-12-2018     |
      | Phone     | +6188888888    |
      | Mobile    |     0422222222 |
      | Email     | some1@some.com |
      | Coach     | Doctor Ferrari |
      | auto      | Retrain        |
    And I hit Enter
    And I select option "65+" from "AgeRange"
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
    And I wait for "1000" milliseconds
    Then I see text "Participant successfully created" displayed

    Examples: 
      | PortalName | EmailAdmin   | Password  | item1     | item2      | item3 | item4  |
      | Bridge     | portaladmin1 | password1 | Last Name | First Name | Email | Status |

@todo...forwnztoaddanactivityfirst
  Scenario Outline: TB-28, TB-39  As a Participant, I want to enroll in an Activity/Service so that I can register my participation
    # Scenario 1: User's session has been inactive
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <Password>   |
    And I click on button with value "Login"
    And I check I am on "Activities" page
    Then I click on text "All Activities"
    #Then "<Item>" is displayed as "<ItemName>"
      #| Fields | Value   |
      #| item1  | <item1> |
      #| item2  | <item2> |
      #| item3  | <item3> |
      #| item4  | <item4> |
    And I "click" row "1" of table "Main"
    And I click on button with value "Enrol"
    #Scenario 2
    Then I see text "You are unable to enrol in this Activity as the maximum capacity has been reached." displayed
    And I wait for "2000" milliseconds
    Then I click on text "Available spaces"
    And I wait for "1000" milliseconds
    Then I click on text "Available spaces"
    And I "click" row "1" of table "Main"
    And I click on button with value "Enrol"
    #Scenario 3
    Then I see text "You have successfully enrolled in this Activity." displayed

    Examples: 
      | PortalName | EmailAdmin                    | Password  | item1                | item2         | item3    | item4            |
      | Bridge     | hemant.shori@dbresults.com.au | Support#1 | Activity Date / Time | Activity Name | Supplier | Available spaces |

  Scenario Outline: TB-12 As a Participant/Supplier, I want to activate and create a password for my account so that I can login to the portal
    # Scenario 1: ONLY PARTIAL AUTOMATED
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I click on text "forgotten my password"
    Then I see text "JUST ENTER YOUR EMAIL" displayed

    Examples: 
      | PortalName |
      | Bridge     |
@Regression
  Scenario Outline: TB-24 As an Admin, I want to search for an Activity so that I can quickly find the Activity I need
    # Scenario 1: User's session has been inactive
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <Password>   |
    And I click on button with value "Login"
    And I check I am on "Activities" page
    And I click on image "search"
    # Scenario 1
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value     |
      | item1  | Announced |
      | item2  | Cancelled |
    And I enter the details as
      | Fields             | Value   |
      | SearchKeywordInput | sssssss |
    And I click on button with value "Search"
    # Scenario 2
    Then I see text "No activities to show..." displayed
    And I enter the details as
      | Fields             | Value |
      | SearchKeywordInput | test  |
    And I click on button with value "Search"
        And I wait for "1000" milliseconds
    And I click on button with value "Reset"
        And I enter the details as
      | Fields             | Value |
      | SearchKeywordInput | test  |
    And I click on button with value "Search"
    #Scenario 3
    And I check that table "Main" with row containing "shori test" returns atleast "1" row
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value         |
      | item1  | Activity Date |
      | item1  | Activity Name |
      | item2  | Supplier      |
      | item2  | Enrolments    |

    Examples: 
      | PortalName | EmailAdmin   | Password  |
      | Bridge     | portaladmin1 | password1 |

  Scenario Outline: TB-25 As an Admin, I want to view a list of Activities so that I know the Activities that have been scheduled
    # Scenario 1:
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <Password>   |
    And I click on button with value "Login"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item4  | <item3> |
      | item5  | <item4> |
    And I click on text "<item1>"
    And I verify sorting is working for "Main" table column "1"
    And I wait for "1000" milliseconds
    And I click on text "<item2>"
    And I verify sorting is working for "Main" table column "2"
    And I wait for "1000" milliseconds
    And I click on text "<item3>"
    And I verify sorting is working for "Main" table column "3"
    #Scenario 2 : Pagination
    And I click on text "next"
    And I wait for "1000" milliseconds
    And I click on text "previous"

    Examples: 
      | PortalName | EmailAdmin   | Password  | item1                | item2         | item3    | item4      |
      | Bridge     | portaladmin1 | password1 | Activity Date / Time | Activity Name | Supplier | Enrolments |

 Scenario Outline: TB-34	 As a Participant, I want to view all the Activities for the Suppliers nominated for me so that I know what Activities I can enroll in
    # Scenario 1: User's session has been inactive
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <Email>    |
      | PasswordInput | <Password> |
    And I click on button with value "Login"
    And I check I am on "Activities" page
    #Scenario 1: Admin selects Create Supplier function
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item4  | <item3> |
      | item5  | <item4> |
      And I verify sorting is working for "Main" table column "1"
         #Scenario 2 : Pagination
    And I click on text "next"
    And I wait for "1000" milliseconds
    And I click on text "previous"
      

    Examples: 
      | PortalName | Email        | Password  | item1 | item2 | item3 | item4 |
      | Bridge     | portaladmin1 | password1 |    Date   |  Activity     |   Supplier    |Enrolments       |

  Scenario Outline: TB-88 As a Participant, I want to view an Activity so that I can view the details of an Activity that has been scheduled
    # Scenario 1:
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <Password>   |
    And I click on button with value "Login"
    And I check I am on "Activities" page
    And I "click" row "1" of table "Main"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item4  | <item3> |
      | item5  | <item5> |
      | item6  | <item6> |
      | item7  | <item7> |
    # Scenario 2
    And I "click" row "1" of table "Main"
    And I wait for "1000" milliseconds

    #  Then I see text "Facilitator" not displayed
    Examples: 
      | PortalName | EmailAdmin                    | Password  | item1      | item2    | item3    | item4       | item5           | item6    | item7       |
      | Bridge     | hemant.shori@dbresults.com.au | Support#1 | Start Time | Location | End Time | Facilitator | Max. Enrolments | Supplier | Description |
      
       Scenario Outline: TB-27 As an Admin, I want to add an Activity so that Participants can access the service
    # Scenario 1: User's session has been inactive
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <Password>   |
    And I click on button with value "Login"
    And I check I am on "Activities" page
    #Scenario 1: Admin user selects the Create button
    And I click on button with value "Create"
    And I check I am on "ActivityDetail" page
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value                  |
      | item1  | Supplier               |
      | item2  | Date                   |
      | item1  | Activity Name          |
      | item2  | Start Time             |
      | item1  | Location               |
      | item2  | End Time               |
      | item1  | NAB Path               |
      | item2  | Max. Participants      |
      | item 1 | Facilitator (Optional) |
      | item 1 | Description            |
    #Scenario 2: Admin user selects a Supplier
    #When I click on button "SupplierId"
    And I select option "ADS" from "Supplier"
    And I click on text "Date"
    And I hit Enter
    #Scenario 3: Admin user enters Activity/Service Name
    And I check "Activity_Name" contains maximum length of "150"
    And I enter the details as
      | Fields        | Value     |
      | Activity_Name | some text |
    #Scenario 4: Admin user enters NAB Path
    And I select "Find a new role" from "Career"
    And I select "Retrain" from "Career"
    And I select "Start a business" from "Career"
    And I select "Take a break" from "Career"
    #Scenario 5: Admin user enters Location
    And I select "Virtual" from "Location"
    And I click on text "Date"
    And I check "Facilitator" contains maximum length of "100"
    #Scenario 6: Admin user enters a Facilitator
    And I enter the details as
      | Fields      | Value     |
      | Facilitator | some text |
    And I select option "00" from "Start"
    And I hit Enter
    And I hit Enter
    And I click on button with value "Save"
    #todo: cover error message popup
    #Scenario 12: An Admin User Creates a new Activity
    Then I see text "Activity successfully created" displayed

    Examples: 
      | PortalName | EmailAdmin   | Password  |
      | Bridge     | portaladmin1 | password1 |
      
@defect
Scenario Outline: TB-21 As an Admin, I want to add/edit a Supplier so that they can can login to the portal
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
      | Supplier_Name | some automated text    |
      | ABN           |            23332131231 |
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
      | Fields    | Value               |
      | FirstName | some automated test |
      | Mobile    |          0200200022 |
      | LastName  | Trump               |
      | Email     | Tru      mpWTF      |
    When I click on button with value "Save"
    Then I see text "Email address must be in a valid format" displayed
    And I click on button with value "Cancel"
    #And I check I am on "Suppliers" page
    #When I click on button with value "Create"
    #Then I check I am on "New Supplier" page
    #
    #And I enter the details as
    #| Fields | Value                         |
    #| FirstName | some automated test |
    #| Mobile    |          0200200022 |
    #| LastName  | Trump               |
    #| wtSupplier_Email  | hemant.shori@dbresults.com.au |
    #
    #When I click on button with value "Save"
    #Scenario 3: Email already exists
    #Then I see text "Email address already exists. Please enter another email address." displayed
    #And I click on button with value "Cancel"
    #Scenario 6: Admin creates Supplier
    And I check I am on "Suppliers" page
    When I click on button with value "Create"
    Then I check I am on "New Supplier" page
    And I enter the details as
      | Fields        | Value                  |
      | Supplier_Name | some automated text    |
      | ABN           |            22332131231 |
      | Address       | automated test address |
      | FirstName     | some automated test    |
      | Mobile        |             0200200022 |
      | LastName      | Trump                  |
      | Email         | a@db.com               |
      #Scenario 4: ABN already exists
    And I capture "ABN"
    When I click on button with value "Save"
      #Scenario 6: Admin creates Supplier
    Then I see text "Supplier record successfully created" displayed

  
    #Scenario 7: Admin edits Supplier with mandatory fields
    Examples: 
      | PortalName | EmailAdmin   | Password  |
      | Bridge     | portaladmin1 | password1 |
     
     
      Scenario Outline: TB-92	 As an Admin, I want to edit Activity and view Participant enrollments so that changes to an Activity can be updated
    # Scenario 1: User's session has been inactive
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <Email>    |
      | PasswordInput | <Password> |
    And I click on button with value "Login"
    And I check I am on "Activities" page
    #Scenario 1: Admin selects Create Supplier function
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item4  | <item3> |
      | item5  | <item4> |
    And I "click" row "2" of table "Main"
    And I wait for "1000" milliseconds
    And I check I am on "ActivityDetail" page
    #Scenario 1:
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value                  |
      | item1  | Supplier               |
      | item2  | Date                   |
      | item1  | Activity Name          |
      | item2  | Start Time             |
      | item1  | Location               |
      | item2  | End Time               |
      | item1  | NAB Path               |
      | item2  | Max. Participants      |
      | item 1 | Facilitator (Optional) |
      | item 1 | Description            |
    And I click on button with value "Cancel"
    And I check I am on "Activities" page
    And I "click" row "2" of table "Main"
    And I check I am on "ActivityDetail" page
    Then I check "Supplier" is readonly
    Then I check "Activity_Name" is readonly
    Then I check "Location" is readonly
    #Scenario 2
    And I check "Facilitator" contains maximum length of "100"

    #ToDO, Scenario 5 and 6 needs more clarification as business rules are not clear.
    Examples: 
      | PortalName | Email        | Password  | item1 | item2    | item3    | item4      |
      | Bridge     | portaladmin1 | password1 | Date  | Activity | Supplier | Enrolments | 
      Scenario Outline: TB-23	As an Admin, I want to search for a Supplier so that I can quickly find the Supplier I need
    # Scenario 1: User's session has been inactive
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <Email>    |
      | PasswordInput | <Password> |
    And I click on button with value "Login"
    And I check I am on "Activities" page
    #Scenario 1: Admin selects Create Supplier function
    And I click on text "Admin"
    And I wait for "1000" milliseconds
    And I click on text "Suppliers"
    And I check I am on "Suppliers" page
    Then I click on button "Search"
    And I wait for "1000" milliseconds
    Then I check "SearchKeywordInput" exists
    # Scenario 2:An Admin user searches for Participants using an existing First Name or Last Name
    And I wait for "1000" milliseconds
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <searchWord> |
    And I hit Enter
    Then I "check" text "<searchWord>" displayed in table "SupplierTable"
    Then I check that table "SupplierTable" with row containing "<searchWord>" returns atleast "1" row
    # Scenario 3: An Admin user searches for Participants using a First or Last Name that does not exist
    Then I click on button "Reset"
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <SearchNone> |
    And I hit Enter
    Then I see text "No suppliers to show..." displayed

    Examples: 
      | PortalName | Email        | Password  | searchWord | SearchNone  |
      | Bridge     | portaladmin1 | password1 | burp       | sunvshvivne |
      
       Scenario Outline: TB-59 :As an Admin, I want to cancel an Activity so that Participants are aware that it is no longer available
    # Scenario 1: Admin views a 'Cancelled' or 'Completed' Activity
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <Password>   |
    And I click on button with value "Login"
    And I wait for "1000" milliseconds
    And I check I am on "Activities" page
    And I "click" row "2" of table "Main"
    And I check I am on "ActivityDetail" page
    Then I check "Supplier" is readonly
    Then I check "Activity_Name" is readonly
    Then I check "Location" is readonly
    # Then I check "NAB Path" is readonly (TBC) Do I need this?
    And I scroll "down" the page
    # Then I see text "Participants" displayed HS?? Unable to get this.
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value      |
      | item1  | Last Name  |
      | item2  | First Name |
      | item3  | Attendance |
    Then I see text "Cancel Activity" not displayed
    # Scenario 2: Admin views a 'Scheduled' Activity' that has no current enrolled Participants
    Then I click on button with value "Cancel"
    And I wait for "1000" milliseconds
    Then I click on text "Activities"
    Then I click on button "Search"
    And I wait for "1000" milliseconds
    Then I check "SearchKeywordInput" exists
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <searchWord> |
    And I hit Enter
    And I wait for "1000" milliseconds
    And I click on text "Upskill Training 1 Melbourne Retrain Start Business Max 25"
    And I scroll "down" the page
    Then I click on button with value "Cancel Activity"
    Then I switch to frame "0"
    And I see text "There are enrolled participants for this activity. You will need to communicate this cancellation to any participants enrolled in this Activity." displayed
    And I see text "Are you sure you want to cancel this Activity?" displayed
    # Need to check button "No" is selected by default HS?? How do we do this?
    Then I click on button with value "No"
    And I wait for "1000" milliseconds
    Then I click on button with value "Cancel Activity"
    Then I switch to frame "0"
    Then I click on button with value "Yes"
    And I see text "Cancellation Reason" displayed
    Then I click on button with value "Cancel"
    # TBD Check text box & character limit & test cancel. Still working on this.
    Then I click on button with value "Cancel Activity"
    Then I switch to frame "0"
    Then I click on button with value "Yes"
    # TBC

    Examples: 
      | PortalName | EmailAdmin   | Password  | item1                | item2         | item3    | item4            | searchWord                                                 |
      | Bridge     | portaladmin1 | password1 | Activity Date / Time | Activity Name | Supplier | Available Spaces | Upskill Training 1 Melbourne Retrain Start Business Max 25 |
      
      
  ################################################################## Following tests have time constraints and should be run in last#####################################
  ################################################################## Following tests have time constraints and should be run in last#####################################
  Scenario Outline: TB-7:As a Participant/Supplier/Admin, I want the portal to log me out during periods of inactivity so that it prevents my user account from being used fraudulently
    # Scenario 1: User's session has been inactive
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value          |
      | UserNameInput | <EmailPart>    |
      | PasswordInput | <PasswordPart> |
    And I wait for "1000" milliseconds
    And I click on button with value "Login"
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I wait for "1000" milliseconds
    Then I see text "All Activities" displayed
    And I wait for "901000" milliseconds
    Then I click on text "View Profile"
    And I wait for "1000" milliseconds
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    Given I want to login to portal "<PortalName>"
    And I wait for "1000" milliseconds
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value         |
      | UserNameInput | <EmailSup>    |
      | PasswordInput | <PasswordSup> |
    And I click on button with value "Login"
    And I wait for "1000" milliseconds
    Then I see text "This page is under construction. Please check back later." displayed
    And I wait for "1000" milliseconds

    # Then I click on button with value "Login Again"
    Examples: 
      | PortalName | EmailPart              | PasswordPart | EmailSup             | PasswordSup |
      | Bridge     | part1@dbresults.com.au | password1    | ac1@dbresults.com.au | password1   |

  Scenario Outline: TB-8, TB-14 :As a Participant/Supplier/Admin, I want my account locked after a number of unsuccessful login attempts so that unathorised users cannot access my account
    # Scenario 1:User locks account
    Given I want to login to portal "<PortalName>"
    And I wait for "1000" milliseconds
    And I check I am on "Login" page
    Then I see text "forgotten my password" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email>     |
      | PasswordInput | <Password0> |
    And I click on button with value "Login"
    Then I see text "Invalid username or password" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email>     |
      | PasswordInput | <Password1> |
    And I click on button with value "Login"
    Then I see text "Invalid username or password" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email>     |
      | PasswordInput | <Password2> |
    And I click on button with value "Login"
    Then I see text "Invalid username or password" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email>     |
      | PasswordInput | <Password3> |
    And I click on button with value "Login"
    Then I see text "Invalid username or password" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email>     |
      | PasswordInput | <Password4> |
    And I click on button with value "Login"
    Then I see text "You have entered incorrect details too many times, please try again in 60 minutes" displayed
    Then I see text "forgotten my password" displayed
    And I wait for "2000" milliseconds
    And I enter the details as
      | Fields        part1@dbresults.com.au | Value      |
      | UserNameInput                        | <Email>    |
      | PasswordInput                        | <Password> |
    And I click on button with value "Login"
    Then I see text "Your account has been locked, please try again in 60 minutes" displayed
    And I wait for "3600000" milliseconds
    And I enter the details as
      | Fields        part1@dbresults.com.au | Value      |
      | UserNameInput                        | <Email>    |
      | PasswordInput                        | <Password> |
    And I click on button with value "Login"
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I check I am on "Activities" page

    Examples: 
      | PortalName | Email             | Password0 | Password1 | Password2 | Password3 | Password4 | Password   |
      | Bridge     | wenzilp@gmail.com | password3 | password3 | password3 | password3 | password3 | redRobin2! |
