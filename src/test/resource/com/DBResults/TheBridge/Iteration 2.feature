Feature: Iteration 2 stories

  Scenario Outline: TB-87 As a Participant, I want to view my Completed Activities so that I can monitor the progress of my Program
    # Scenario 1:No enrollment in a completed Activity
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value          |
      | UserNameInput | <EmailPart1>   |
      | PasswordInput | <PasswordPart> |
    And I click on button with value "Login"
    Then I click on text "All Activities"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
    And I wait for "1000" milliseconds
    Then I click on text "Completed"
    Then "<ItemN>" is displayed as "<ItemNameN>"
      | Fields | Value   |
      | item2  | <item2> |
    And I wait for "1000" milliseconds
    Then I click on text "My Program"
    Then I click on button "Logout"
    # Scenario 2: Enrollment in a completed Activity
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value          |
      | UserNameInput | <EmailPart2>   |
      | PasswordInput | <PasswordPart> |
    And I hit Enter
    Then I click on text "Completed"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item3  | <item3> |
      | item4  | <item4> |
      | item5  | <item5> |
      | item6  | <item6> |
    And I wait for "1000" milliseconds
    And I click on text "<item3>"
    And I verify sorting is working for "Main" table column "1"
    And I wait for "1000" milliseconds
    And I click on text "<item4>"
    And I verify sorting is working for "Main" table column "2"
    And I wait for "1000" milliseconds
    And I click on text "<item5>"
    And I verify sorting is working for "Main" table column "3"
    And I wait for "1000" milliseconds
    And I click on text "<item6>"
    And I verify sorting is working for "Main" table column "4"
    # Scenario 3: Participant views a past activity’s details.
    And I wait for "1000" milliseconds
    And I "click" row "1" of table "Main"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value    |
      | item7  | <item7>  |
      | item8  | <item8>  |
      | item9  | <item9>  |
      | item10 | <item10> |
      | item11 | <item11> |
      | item12 | <item12> |

    Examples: 
      | PortalName | EmailPart1            | EmailPart2         | PasswordPart | All Activities | Completed | item1                    | item2                                                                                    | item3       | item4 | item5    | item6      | item7      | item8    | item9    | item10      | item11          | item12      |
      | Bridge     | kixosop@one2mail.info | bosik@eth2btc.info | redRobin2!   | All Activities | Completed | No activities to show... | You haven’t completed an activity yet. View your upcoming activities through My Program. | Date / Time | Name  | Supplier | Attendance | Start Time | Location | End Time | Facilitator | Max. Enrolments | Description |


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
    And I click on text "Completed"
    Then I click on button "Search"
    And I wait for "1000" milliseconds
    Then I check "SearchKeywordInput" exists
    And I enter the details as
      | Fields             | Value          |
      | SearchKeywordInput | <searchCancel> |
    And I hit Enter
    And I wait for "1000" milliseconds
    And I click on text "BapaTest"
    #And I "click" row "2" of table "Main"
    And I check I am on "ActivityInfo" page
    Then I see text "Supplier" not displayed
    Then I see text "Activity Name" displayed
    Then I see text "Location" displayed
    Then I see text "NAB Path" displayed
    #is readonly (TBC) Do I need this?
    And I scroll "down" the page
    # Then I see text "Participants" displayed HS??
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
    And I click on text "Acme Training 101 - Retirement & Take Break Sydney"
    And I check I am on "ActivityDetail" page
    Then I check "Supplier" is readonly
    Then I check "Activity_Name" is readonly
    Then I check "Location" is readonly
    Then I check "CareerListBox" is readonly
    And I scroll "down" the page
    Then I click on button with value "Cancel Activity"
    Then I switch to frame "0"
    Then I click on button with value "Yes"
    And I see text "Cancellation Reason" displayed
    Then I click on button with value "Save"
    And I see text "Required field!" displayed
    Then I click on button with value "Cancel"
    And I wait for "1000" milliseconds
    # Scenario 3: Admin views a 'Scheduled' Activity' that has current enrolled Participants
    Then I click on button with value "Cancel"
    And I wait for "1000" milliseconds
    Given I click on text "Activities"
    Then I click on button "Search"
    And I wait for "1000" milliseconds
    Then I check "SearchKeywordInput" exists
    And I enter the details as
      | Fields             | Value             |
      | SearchKeywordInput | <searchScheduled> |
    And I hit Enter
    And I wait for "1000" milliseconds
    And I click on text "Upskill Training 1 Melbourne Retrain Start Business Max 25"
    And I check I am on "ActivityDetail" page
    Then I check "Supplier" is readonly
    Then I check "Activity_Name" is readonly
    Then I check "Location" is readonly
    Then I check "CareerListBox" is readonly
    And I scroll "down" the page
    Then I click on button with value "Cancel Activity"
    Then I switch to frame "0"
    And I see text "There are enrolled participants for this activity. You will need to communicate this cancellation to any participants enrolled in this Activity." displayed
    And I see text "Are you sure you want to cancel this Activity?" displayed
    # Need to check button "No" is selected by default HS??
    Then I click on button with value "No"
    And I wait for "1000" milliseconds
    Then I click on button with value "Cancel Activity"
    Then I switch to frame "0"
    And I see text "There are enrolled participants for this activity. You will need to communicate this cancellation to any participants enrolled in this Activity." displayed
    And I see text "Are you sure you want to cancel this Activity?" displayed
    Then I click on button with value "Yes"
    And I see text "Cancellation Reason" displayed
    Then I click on button with value "Cancel"
    And I wait for "1000" milliseconds
    Then I click on button with value "Cancel Activity"
    Then I switch to frame "0"
    Then I click on button with value "Yes"
    And I wait for "1000" milliseconds
    Then I click on button with value "Save"
    And I see text "Required field!" displayed
    And I enter the details as
      | Fields            | Value          |
      | CancelReasonInput | <CancelReason> |
      Then I click on button with value "Save"

      

    #  Activity is cancelled and is no longer available for display on the Scheduled Activities screens.
    # The status of the Activity is updated to 'Cancelled'
    Examples: 
      | PortalName | EmailAdmin   | Password  | item1                | item2         | item3    | item4            | searchCancel | searchWord                                         | searchScheduled                                            | CancelReason                                                                                                                                                                              |
      | Bridge     | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Activity Date / Time | Activity Name | Supplier | Available Spaces | BapaTest     | Acme Training 101 - Retirement & Take Break Sydney | Upskill Training 1 Melbourne Retrain Start Business Max 25 | The cancellation reason is a mandatory free text max 125 characters reason for cancellation. The cancellation reason is a mandatory free text max 125 characters reason for cancellation. |

  Scenario Outline: TB-40, TB-41 As an Admin/Participant, I want to view a list of documents in the Document Library so that I can view information published
    # Scenario 1: An Admin user logs in to the portal to view a list of documents in the Document Library*
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <EmailPart> |
      | PasswordInput | <Password>  |
    And I click on button with value "Login"
    Then I see text "WELCOME TO THE BRIDGE" displayed
    Then I click on text "Documents"
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
    Then I check that table "Main" with row containing "Completed" returns atleast "1" row
    # Scenario 2: A Participant logs in to the portal to view a list of documents in the Document Library*
    Then I "click" table "DocumentStoreTable" exist and row "1" containing image "Icon_download"

    # Scenario 3: A Supplier logs in to the portal to view a list of documents in the Document Library*
    # ******************Existing bug need to be fixed, can not continue 40*********************88
    # Scenario 4: An Admin or Participant views the Document list, leaves the screen, and returns to view the Documents list*
    # Scenario 5: An Admin or Participant views a Document from the Documents list*
    Examples: 
      | PortalName | EmailPart                     | Password   | item1 | item2    | item3    | item4         |
      | Bridge     | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Name  | NAB Path | Category | Date Uploaded |

  Scenario Outline: TB-77: As an Admin, I want to add a Participant note so that I can record important information about the Participant
    # Scenario 1:Admin adds a Note when Adding a Participant
    Given I want to login to portal "<PortalName>"
    And I wait for "2000" milliseconds
    And I check I am on "Login" page
    And I enter the details as
      | Fields        | Value           |
      | UserNameInput | <EmailAdmin>    |
      | PasswordInput | <PasswordAdmin> |
    And I hit Enter
    Then I click on text "Admin"
    Then I click on text "Participants"
    And I click on button with value "Create"
    And I check I am on "ParticipantDetail" page
    Then I select option "Female" from "Gender"
    And I select option "1991" from "YearJoined"
    And I enter the details as
      | Fields    | Value          |
      | FirstName | Wendy          |
      | Email     | we4s@some.com  |
      | Phone     | +6188888888    |
      | Mobile    |     0422222222 |
      | Coach     | Doctor Ferrari |
      | auto      | Retrain        |
    And I hit Enter
    And I enter "we4s" with the current date prepended into "LastName"
    And I select option "65+" from "AgeRange"
    And I select option "4" from "GroupLevel"
    And I select option "Melbourne, VIC" from "Location"
    Then I click on text "Duplication"
    Then I click on text "Acme Holdings LImited"
    Then I click on text "Skills Australia"
    Then I click on text "The Bridge"
    Then I click on text "Upskill Australia"
    Then I click on text "Field Validation Co"
    And I select option "Coaching Note" from "MainContent"
    And I enter the details as
      | Fields        | Value           |
      | Note_Content2 | <Note_Content2> |
    And I click on button with value "Save"
    And I wait for "1000" milliseconds
    Then I see text "Participant successfully created" displayed
    # Scenario 2: Admin adds a Note when Editing a Participant without existing Notes
    And I wait for "1000" milliseconds
    Then I click on text "Admin"
    Then I click on text "Participants"
    Then I click on button "Search"
    And I wait for "1000" milliseconds
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <searchWord> |
    And I hit Enter
    Then I "check" text "<searchWord>" displayed in table "ParticipantTable"
    Then I click on text "03-04-2018we4s"
    And I wait for "1000" milliseconds
    And I scroll "down" the page
    And I select option "Administrator Note" from "MainContent"
    And I enter the details as
      | Fields        | Value           |
      | Note_Content2 | <Note_Content2> |
    And I click on button with value "Save"
    And I wait for "1000" milliseconds
    Then I see text "Participant successfully updated" displayed
    #  Scenario 3. Admin views an existing Note when Editing a Participant
    And I wait for "1000" milliseconds
    Then I click on text "Admin"
    Then I click on text "Participants"
    Then I click on button "Search"
    And I wait for "1000" milliseconds
    And I enter the details as
      | Fields             | Value        |
      | SearchKeywordInput | <searchWord> |
    And I hit Enter
    Then I "check" text "<searchWord>" displayed in table "ParticipantTable"
    And I wait for "1000" milliseconds
    Then I click on text "03-04-2018we4s"
    And I wait for "1000" milliseconds
    And I scroll "down" the page
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value              |
      | item1  | Administrator Note |
      | item2  | Coaching Note      |
    Then I check "NoteCreatedByandWhen" exists
    Then I check "NoteType" exists
    Then I check "NoteRecords" exists
    #  Scenario 4: Admin cancels adding a new Note when Editing a Participant
    And I wait for "1000" milliseconds
    And I select option "Coaching Note" from "MainContent"
    And I enter the details as
      | Fields        | Value           |
      | Note_Content2 | <Note_Content2> |
    And I click on button with value "Cancel"
    And I wait for "1000" milliseconds
    #  Scenario 4a:When the Admin user clicks on the 'Cancel' button
    Then I see "Unsaved changes will be lost. Are you sure?" displayed on popup and I click "Cancel"
    Then I check I am on "ParticipantDetail" page
    And "<Item>" is displayed as "<ItemName>"
      | Fields        | Value           |
      | Note_Content3 | <Note_Content3> |
    #  Scenario 4b:When the Admin user clicks on the 'OK' button
    And I click on button with value "Cancel"
    And I wait for "1000" milliseconds
    Then I see "Unsaved changes will be lost. Are you sure?" displayed on popup and I click "OK"
    Then I check I am on "ParticipantList" page
    # Scenario 5: Admin user views multiple existing Notes when Editing a Participant
    And I click on image "search"
    And I wait for "1000" milliseconds
    And I click on button "Reset"
    Then I check "SearchKeywordInput" exists
    And I enter the details as
      | Fields             | Value       |
      | SearchKeywordInput | <searchJob> |
    And I hit Enter
    And I check that table "ParticipantTable" with row containing "Job" returns atleast "1" row
    And I click on text "Jobs"
    And I wait for "1000" milliseconds
    Then I check I am on "ParticipantDetail" page
    And I scroll "down" the page
    And "<Item>" is displayed as "<ItemName>"
      | Item        | ItemName |
      | MainContent | Show All |
    And I wait for "1000" milliseconds
    And I scroll "down" the page
    Then I click on text "Show All"
    And I wait for "1000" milliseconds
    And I scroll "down" the page
    And I wait for "1000" milliseconds
    Then I click on text "Hide"
    # Scenario 6: Admin user filters on multiple existing Notes when Editing a Participant
    And I wait for "1000" milliseconds
    And I click on text "Back to top"
    And I wait for "1000" milliseconds
    And I scroll "down" the page
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value              |
      | item1  | Administrator Note |
      | item2  | Coaching Note      |
    Then I check "NoteCreatedByandWhen" exists
    Then I check "NoteType" exists
    Then I check "NoteRecords" exists
    # Then I click on "NoteType2" checkbox
    # these steps need to be raised with devs in it3
    #Then I click on text "Administrator Note"
    When I click on checkbox with id "TBStyleGuide_wt51_block_wtMainContent_wtListRecords1_ctl00_wtNoteType2"
    Then I see text "Administrator Note" not displayed in "ShowNotesSection"
    When I click on checkbox with id "TBStyleGuide_wt51_block_wtMainContent_wtListRecords1_ctl02_wtNoteType2"
    Then I see text "Administrator Note" not displayed in "Coaching Note"

    Examples: 
      | PortalName | EmailAdmin   | PasswordAdmin | searchWord     | searchJob | MainContent | item1              | item2         | Note_Content2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Note_Content3                                                                                                                                                                                                            |
      | Bridge     | wenzil.admin@dbresults.com.au | WOsdrdoTlO      | 03-04-2018we4s | Job       | Show All    | Administrator Note | Coaching Note | Optional Notes with character limit of 500 And the Admin user is able to enter a maximum of 500 alphanumeric and special characters into the free-text box located beneath the Notes drop-down field When the Admin user clicks the 'Save' button Then the Participant record is created and the Admin user is presented with a success feedback message advising 'Participant successfully created'.  And the Admin user is able to enter a maximum of 500 alphanumeric  this ex  123 is not displaye and 123 not d | Optional Notes with character limit of 500 And the Admin user is able to enter a maximum of 500 alphanumeric and special characters into the free-text box located beneath the Notes drop-down field When the Admin user |

  Scenario Outline: TB-185: As an Admin, I want to be able to view a list of all Activities so that I can track its progress
    # Scenario 1: Admin views all created Activities
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <PwdAdmin>   |
    And I click on button with value "Login"
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I wait for "1000" milliseconds
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item3  | <item3> |
      | item4  | <item4> |
      | item5  | <item5> |
      | item6  | <item6> |
    And I click on text "<item1>"
    And I verify sorting is working for "Main" table column "1"
    And I wait for "1000" milliseconds
    And I click on text "<item2>"
    And I verify sorting is working for "Main" table column "2"
    And I wait for "1000" milliseconds
    And I click on text "<item3>"
    And I verify sorting is working for "Main" table column "3"
    And I wait for "1000" milliseconds
    And I click on text "<item4>"
    And I verify sorting is working for "Main" table column "4"
    And I wait for "1000" milliseconds
    And I click on text "<item5>"
    And I verify sorting is working for "Main" table column "5"
    And I wait for "1000" milliseconds
    And I click on text "<item6>"
    And I verify sorting is working for "Main" table column "6"
    Then I see text "Cancelled" not displayed
    # Check why we have this here???
    #Then I see text "Completed" not displayed
    # Scenario 2: Admin views all completed Activities
    Then I click on text "Completed"
    And I wait for "1000" milliseconds
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item3  | <item3> |
      | item4  | <item4> |
      | item5  | <item5> |
      | item6  | <item6> |
    And I click on text "<item1>"
    And I verify sorting is working for "Main" table column "1"
    And I wait for "1000" milliseconds
    And I click on text "<item2>"
    And I verify sorting is working for "Main" table column "2"
    And I wait for "1000" milliseconds
    And I click on text "<item3>"
    And I verify sorting is working for "Main" table column "3"
    And I wait for "1000" milliseconds
    And I click on text "<item4>"
    And I verify sorting is working for "Main" table column "4"
    And I wait for "1000" milliseconds
    And I click on text "<item5>"
    And I verify sorting is working for "Main" table column "5"
    And I wait for "1000" milliseconds
    And I click on text "<item6>"
    And I verify sorting is working for "Main" table column "6"
    And I wait for "1000" milliseconds
    Then I see text "In Progress" not displayed
    Then I see text "Announced" not displayed

    Examples: 
      | PortalName | EmailAdmin                    | PwdAdmin   | item1       | item2 | item3    | item4    | item5      | item6  |
      | Bridge     | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Date / Time | Name  | Supplier | Location | Enrolments | Status |

      

   Scenario Outline: TB-44: As an Admin, I want to upload Documents to the Document library so that the information can be viewed by Admin users and Participants
    #Scenario 1: A Participant logs in and views the Document Library – Upload not visible
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <EmailPart> |
      | PasswordInput | <Password>  |
    And I click on button with value "Login"
    Then I see text "WELCOME TO THE BRIDGE" displayed
    Then I click on text "Documents"
    And I wait for "1000" milliseconds
    Then I click on button "Logout"
    And I wait for "1000" milliseconds
    And I click on button with value "Login Again"
    # Scenario 2: An Admin user clicks on Upload in the Document Library
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <PwdAdmin>   |
    And I click on button with value "Login"
    Then I see text "WELCOME TO THE BRIDGE" displayed
    Then I click on text "Documents"
    Then I click on button with value "Upload"
    Then I switch to frame "0"
    And I see text "File size must be under 10 MB, accepted file formats are Word, Excel, PPT, PDF, JPGs, GIF and PNG." displayed
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item3  | <item3> |
      | item4  | <item4> |
      | item5  | <item5> |
    # Scenario 3: File type not supported
    # HS - needs file upload
    And I select "<Retrain>" from "Career"
    And I select "<Bridge Sydney>" from "Category"
    Then I click on button with value "Browse"
    #change following with some local file in dox
    And I upload a "<whichFile>" file
    And I click on button with value "Cancel"
    Then I check I am on "Documents" page
    Then I click on button with value "Upload"
    Then I switch to frame "0"
    And I see text "File size must be under 10 MB, accepted file formats are Word, Excel, PPT, PDF, JPGs, GIF and PNG." displayed
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item3  | <item3> |
      | item4  | <item4> |
      | item5  | <item5> |
    # Scenario 3: File type not supported
    # HS - needs file upload
    And I select "<Retrain>" from "Career"
    And I select "<Bridge Sydney>" from "Category"
    And I select "<The Bridge>" from "SupplierCombo"
    Then I click on button with value "Browse"
    #change following with some local file in dox
    And I upload a "<whichFile>" file
    And I click on button with value "Save"
    And I hit Enter
    # And I click on button with value "<SomeValue>"
    Then I see text "<ExpectedTxt>" displayed

    #Scenario:4,5 should not be automated, 6,7,8,9,10 are below
    Examples: 
      | PortalName | EmailPart          | Password   | EmailAdmin                    | PwdAdmin   | item1  | item2    | item3    | item4  | item5       | whichFile | Retrain | Bridge Sydney |The Bridge |ExpectedTxt                          | SomeValue |
      | Bridge     | bosik@eth2btc.info | redRobin2! | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Upload | NAB Path | Category | Cancel | MainContent | Lisa.jmx  | Retrain | Bridge Sydney |The Bridge |Invalid file type. Please try again. |           |
      | Bridge     | bosik@eth2btc.info | redRobin2! | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Upload | NAB Path | Category | Cancel | MainContent | 44.xlxs   | Retrain | Bridge Sydney |The Bridge |File successfully uploaded.          |           |

  Scenario Outline: TB-46: As an Admin, I want to delete a Document from the Document library so that I can remove documents no longer required
    #Scenario 1:Scenario 1. Admin clicks on the delete icon in the Documents library*
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <PwdAdmin>   |
    And I click on button with value "Login"
    Then I see text "WELCOME TO THE BRIDGE" displayed
    Then I click on text "Documents"
    And I click on image "search"
    And I wait for "1000" milliseconds
    Then I check "SearchKeywordInput" exists
    And I wait for "1000" milliseconds
    And I enter the details as
      | Fields             | Value       |
      | SearchKeywordInput | <whichFile> |
    And I click on button with value "Search"
    And I click on image "Icon_delete"
    And I wait for "1000" milliseconds
    Then I switch to frame "0"
    Then I click on "Yes" on popup
    And I wait for "2000" milliseconds
    Then I see text "Successfully Deleted" displayed

    Examples: 
      | PortalName | EmailPart          | Password   | EmailAdmin                    | PwdAdmin   | item1  | item2    | item3    | item4  | item5       | whichFile | Retrain | Bridge Sydney | ExpectedTxt                 | SomeValue |
      | Bridge     | bosik@eth2btc.info | redRobin2! | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Upload | NAB Path | Category | Cancel | MainContent | 44.xlxs   | Retrain | Bridge Sydney | File successfully uploaded. |           |

   
  Scenario Outline: TB-44B: As an Admin, I want to upload Documents to the Document library so that the information can be viewed by Admin users and Participants
    #Scenario 1: A Participant logs in and views the Document Library – Upload not visible
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <EmailPart> |
      | PasswordInput | <Password>  |
    And I click on button with value "Login"
    Then I see text "WELCOME TO THE BRIDGE" displayed
    Then I click on text "Documents"
    And I wait for "1000" milliseconds
    Then I click on button "Logout"
    And I wait for "1000" milliseconds
    And I click on button with value "Login Again"
    # Scenario 2: An Admin user clicks on Upload in the Document Library
    Given I want to login to portal "<PortalName>"
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value        |
      | UserNameInput | <EmailAdmin> |
      | PasswordInput | <PwdAdmin>   |
    And I click on button with value "Login"
    Then I see text "WELCOME TO THE BRIDGE" displayed
    Then I click on text "Documents"
    Then I click on button with value "Upload"
    Then I switch to frame "0"
    And I see text "File size must be under 10 MB, accepted file formats are Word, Excel, PPT, PDF, JPGs, GIF and PNG." displayed
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item3  | <item3> |
      | item4  | <item4> |
      | item5  | <item5> |
    # Scenario 3: File type not supported
    # HS - needs file upload
    And I select "<Retrain>" from "Career"
    And I select "<Bridge Sydney>" from "Category"
    Then I click on button with value "Browse"
    #change following with some local file in dox
    And I upload a "<whichFile>" file
    And I click on button with value "Cancel"
    Then I check I am on "Documents" page
    Then I click on button with value "Upload"
    Then I switch to frame "0"
    And I see text "File size must be under 10 MB, accepted file formats are Word, Excel, PPT, PDF, JPGs, GIF and PNG." displayed
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item3  | <item3> |
      | item4  | <item4> |
      | item5  | <item5> |
    # Scenario 3: File type not supported
    # HS - needs file upload
    And I select "<Retrain>" from "Career"
    And I select "<Bridge Sydney>" from "Category"
    Then I click on button with value "Browse"
    #change following with some local file in dox
    And I upload a "<whichFile>" file
    And I click on button with value "<SomeButton>"
    # And I click on button with value "<SomeValue>"
    And I wait for "1000" milliseconds
    Then I see text "<ExpectedTxt>" displayed

    #Scenario:4,5 should not be automated, 6,7,8,9,10 are below
    Examples: 
      | PortalName | EmailPart          | Password   | EmailAdmin                    | PwdAdmin   | item1  | item2    | item3    | item4  | item5       | whichFile | Retrain | Bridge Sydney | ExpectedTxt               | SomeButton |
      | Bridge     | bosik@eth2btc.info | redRobin2! | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Upload | NAB Path | Category | Cancel | MainContent | Test.xlsx |         | Bridge Sydney |                           | Save       |
      | Bridge     | bosik@eth2btc.info | redRobin2! | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Upload | NAB Path | Category | Cancel | MainContent | Test.xlsx | Retrain | Bridge Sydney | File name already exists. | Save       |
      
      
      
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
    And I select option "00" from "EndHour"
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
    And I check I am on "ActivityDetail" page
    Then I check "Supplier" is readonly
    Then I check "Activity" is readonly
    Then I check "NAB" is readonly
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
@e2e
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
    And I select option "00" from "EndHour"
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
      
      
      