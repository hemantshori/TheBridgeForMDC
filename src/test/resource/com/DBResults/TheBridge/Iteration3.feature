Feature: It 3
@wip
  Scenario Outline: TB-26: As an Admin, I want to post Notices so that public announcements can be communicated to portal users
    # Scenario 1: Admin can see the Post Noticeboard function
    Given I want to login to portal "<PortalName>"
    And I wait for "1000" milliseconds
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email>     |
      | PasswordInput | <Password1> |
    And I wait for "1000" milliseconds
    And I hit Enter
    And I wait for "1000" milliseconds
    And I check I am on "Activities" page
    And I wait for "1000" milliseconds
    Then I click on text "Noticeboard"
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item3  | <item3> |
      | item4  | <item4> |
      | item5  | <item5> |
    # Scenario 2: Admin post a notice with mandatory fields not filled in
    And I wait for "1000" milliseconds
    And I enter the details as
      | Fields         | Value                                                                                                                                                                                                           |
      | Notice_Heading | ABC It's easy as, 1 2 3                                                                                                                                                                                         |
      | Notice_Content | You went to school to learn girl Things you never, never knew before Like "I" before "E" except after "C" And why 2 plus 2 makes 4 Now, now, now I'm gonna teach you (Teach you, teach you) All about love girl |
    # 4 HS: And I upload a "<whichFile>" file
    And I wait for "1000" milliseconds
    # Scenario 4: Admin aborts cancelling a Notice creation with unsaved changes
    Then I click on button "Discard"
    And I see "Unsaved changes will be lost. Are you sure?" displayed on popup and I click "OK"
    And I check I am on "Notice Board" page
    And I wait for "1000" milliseconds
    Then I click on button "Post"
    # Scenario 5: Admin cancels Notice creation with unsaved changes
    Then I see text "Mandatory fields must be filled in." displayed
    And I see text "Required field!" displayed
    And I enter the details as
      | Fields         | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
      | Notice_Heading | ABC It's easy as, 1 2 3                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
      | Notice_Content | You went to school to learn girl Things you never, never knew before Like "I" before "E" except after "C" And why 2 plus 2 makes 4 Now, now, now I'm gonna teach you (Teach you, teach you) All about love girl (All about love) Sit yourself down, take a seat All you gotta do is repeat after me A B C It's easy as, 1 2 3 As simple as, do re mi A B C, 1 2 3 Baby, you and me girl A B C It's easy as, 1 2 3 As simple as, do re mi A B C, 1 2 3 Baby, you and me girl |
    # And I enter "ABC" with the current date prepended into "Notice_Heading"
    # 4 HS: And I upload a "<whichFile>" file
    And I wait for "1000" milliseconds
    # Scenario 3: Admin post a notice with mandatory fields filled in
    Then I click on button "Post"
    Then I see text "Notice successfully created." displayed
    And I check I am on "Notice Board" page
    And I wait for "1000" milliseconds

    Examples: 
      | PortalName | Email                         | Password1  | SomePage | some text      | item1   | item2       | item3       | item4         | item5      | whichFile |
      | Bridge     | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Admin    | Administrators | Heading | Description | ImageUpload | DiscardButton | PostButton | ABC.jpg   |

  Scenario Outline: TB-14:As a Superadmin, I want to configure the settings for 'The Bridge' portal so that it's based on the organisation's preferences
    # Scenario 1: Superadmin views the Admin menu options
    Given I want to login to portal "<PortalName>"
    And I wait for "1000" milliseconds
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value       |
      | UserNameInput | <Email>     |
      | PasswordInput | <Password1> |
    And I wait for "1000" milliseconds
    And I hit Enter
    Then I click on text "Admin"
    Then I click on text "<some text>"
    And I check I am on "<SomePage>" page
    # Scenario 2: Superadmin views the portal’s configuration settings.
    And I wait for "1000" milliseconds
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item3  | <item3> |
      | item4  | <item4> |
      | item5  | <item5> |
      | item6  | <item6> |
      | item7  | <item7> |
      | item8  | <item8> |
    Then I check "Cancel" exists
    # Then I check "Save" exists
    # Scenario 3: Mandatory fields not filled in
    And I enter the details as
      | Fields                                 | Value |
      | AccountLockNoOfAttempts2               |       |
      | AccountLockoutPeriod2                  |    60 |
      | ActivationExpiryPeriod4                |     0 |
      | LockoutAttemptTimeframe                |    60 |
      | GeneralEmail2                          |       |
      | ActivityReminderNotification2          |     2 |
      | ActivationReminderNotificationOne      |     1 |
      | AccessTerminationReminderNotification2 |    30 |
      | ActivationReminderNotificationTwo      |     2 |
    And I click on button with value "Save"
    Then I see text "<ExpectedMsg>" displayed
    # Scenario 4: Email address not in a valid format
    And I enter the details as
      | Fields                                 | Value   |
      | AccountLockNoOfAttempts2               |       5 |
      | AccountLockoutPeriod2                  |      60 |
      | ActivationExpiryPeriod4                |       0 |
      | LockoutAttemptTimeframe                |      60 |
      | GeneralEmail2                          | abc@abc |
      | ActivityReminderNotification2          |       2 |
      | ActivationReminderNotificationOne      |       1 |
      | AccessTerminationReminderNotification2 |      30 |
      | ActivationReminderNotificationTwo      |       2 |
    And I click on button with value "Save"
    Then I see text "<ExpectedTxt>" displayed
    # Scenario 7: Superadmin cancels with unsaved changes
    And I enter the details as
      | Fields                                 | Value       |
      | AccountLockNoOfAttempts2               |           5 |
      | AccountLockoutPeriod2                  |          60 |
      | ActivationExpiryPeriod4                |           0 |
      | LockoutAttemptTimeframe                |          60 |
      | GeneralEmail2                          | abc@abc.com |
      | ActivityReminderNotification2          |           2 |
      | ActivationReminderNotificationOne      |           1 |
      | AccessTerminationReminderNotification2 |          30 |
      | ActivationReminderNotificationTwo      |           2 |
    And I click on button with value "Cancel"
    Then I see "Unsaved changes will be lost. Are you sure?" displayed on popup and I click "Cancel"
    Then I check I am on "<SomePage>" page
    Then I wait for "1000" milliseconds
    # Scenario 6: Superadmin cancels with no unsaved changes
    Then I click on text "Admin"
    Then I click on text "<some text>"
    And I check I am on "<SomePage>" page
    And I wait for "1000" milliseconds
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item3  | <item3> |
      | item4  | <item4> |
      | item5  | <item5> |
      | item6  | <item6> |
      | item7  | <item7> |
      | item8  | <item8> |
    And I click on button with value "Cancel"
    Then I check I am on "Activities" page
    Then I wait for "1000" milliseconds
    # Scenario 5: Superadmin updates the portal’s configuration settings
    Then I click on text "Admin"
    Then I click on text "<some text>"
    And I check I am on "<SomePage>" page
    And I enter the details as
      | Fields                                 | Value       |
      | AccountLockNoOfAttempts2               |           5 |
      | AccountLockoutPeriod2                  |          60 |
      | ActivationExpiryPeriod4                |           0 |
      | LockoutAttemptTimeframe                |          60 |
      | GeneralEmail2                          | abc@abc.com |
      | ActivityReminderNotification2          |           2 |
      | ActivationReminderNotificationOne      |           1 |
      | AccessTerminationReminderNotification2 |          30 |
      | ActivationReminderNotificationTwo      |           2 |
    And I click on button with value "Save"
    Then I see text "<SuccessTxt>" displayed

    Examples: 
      | PortalName | Email                       | Password1      | SomePage            | some text     | item1                                | item2                         | item3                                    | item4                            | item5         | item6                                 | item7                                     | item8                                           | item9                                     | SuccessTxt                          | ExpectedMsg                         | ExpectedTxt                             |
      | Bridge     | superadmin@dbresults.com.au | SuperAdmin123! | ApplicationSettings | Configuration | Max Number of Account Lock  Attempts | Account Lockout Period (mins) | Account Activation Expiry Period (hours) | Account Lockout Timeframe (mins) | General Email | Activity Reminder Notification (days) | Activation Reminder Notification 1 (days) | Access Termination Reminder Notification (days) | Activation Reminder Notification 2 (days) | Configuration successfully updated. | Mandatory fields must be filled in. | Email address must be in a valid format |

  Scenario Outline: TB-83:As a Participant/Admin/Supplier, I want to access my Quick Links so that I can quickly access the information I need
    # Scenario 1: Supplier can see the Participant comment function
    Given I want to login to portal "<PortalName>"
    And I wait for "1000" milliseconds
    And I check I am on "Login" page
    Then I see text "WELCOME TO THE BRIDGE" displayed
    And I enter the details as
      | Fields        | Value      |
      | UserNameInput | <Email>    |
      | PasswordInput | <Password> |
    And I wait for "1000" milliseconds
    And I hit Enter
    Then "<Item>" is displayed as "<ItemName>"
      | Fields | Value   |
      | item1  | <item1> |
      | item2  | <item2> |
      | item3  | <item3> |
      | item4  | <item4> |
      | item5  | <item5> |
    Then I see text "<notitem1>" not displayed
    Then I see text "<notitem2>" not displayed
    Then I see text "<notitem3>" not displayed
    Then I click on text "<item2>"
    And I wait for "2000" milliseconds
    Then a new page "<url>" is launched

    Examples: 
      | PortalName | Email                         | Password   | searchWord | item1            | item2             | item3                | notitem1         | notitem2          | notitem3             | item4      | item5   | item20                      | item21     | url                                          |
      | Bridge     | bosik@eth2btc.info            | redRobin2! | redDNT     | Give Us Feedback | Open Universities | Skilled Volunteering |                  |                   |                      | Contact Us |         | Open Universities Australia | The Bridge | http://www.studyonline.open.edu.au/thebridge |
      | Bridge     | wenzil.admin@dbresults.com.au | WOsdrdoTlO | redDNT     |                  |                   |                      | Give Us Feedback | Open Universities | Skilled Volunteering |            | Reports |                             |            |                                              |
      | Bridge     | motika@twocowmail.net         | redRobin2! | redDNT     |                  |                   |                      | Give Us Feedback | Open Universities | Skilled Volunteering | Contact Us | Reports |                             |            |                                              |

  Scenario Outline: E2E, activity generate data for TB-59
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
    # Auto test pre condition create an activity with participant enrolled
    And I click on button with value "Create"
    And I check I am on "ActivityDetail" page
    Then I select option "BC3 Auto Co" from "Activity_SupplierId"
    And I select option "Melbourne, VIC" from "Activity_LocationId"
    And I select option "00" from "EndHour"
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
    And I wait for "1000" milliseconds
    Then I see text "Activity successfully created" displayed
    And I wait for "1000" milliseconds
    # Auto test pre condition create an activity with no participant
    And I click on button with value "Create"
    And I check I am on "ActivityDetail" page
    Then I select option "BC3 Auto Co" from "Activity_SupplierId"
    And I select option "Melbourne, VIC" from "Activity_LocationId"
    And I select option "00" from "EndHour"
    And I enter the details as
      | Fields                   | Value |
      | Activity_MaxParticipants |     1 |
    And I enter "05-05-2018" with the current date prepended into "Activity_ActivityDate"
    And I hit Enter
    And I enter the details as
      | Fields        | Value        |
      | Activity_Name | <searchNone> |
    And I select "Find a new role" from "Career"
    And I select "Retrain" from "Career"
    And I select "Start a business" from "Career"
    Then I click on button with value "Save"
    And I wait for "1000" milliseconds
    Then I see text "Activity successfully created" displayed
    And I click on button "Logout"
    Then I click on button with value "Login Again"
    # Scenario: Login as bc3 and enrol into above searchWord activity
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
    And I "click" row "1" of table "Main"
    And I click on button with value "Enrol"
    And I wait for "1000" milliseconds
    Then I see text "You have successfully enrolled in this Activity." displayed
    And I wait for "1000" milliseconds

    Examples: 
      | PortalName | Email                         | Password   | item1 | item2    | item3    | item4      | searchWord  | searchNone  | Email2               | Password2 |
      | Bridge     | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Date  | Activity | Supplier | Enrolments | someautoDNT | NoneautoDNT | bc3@dbresults.com.au | password1 |

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
    And I check I am on "ActivityInfo" page
    Then I see text "Supplier" not displayed
    Then I see text "Activity Name" displayed
    Then I see text "Location" displayed
    Then I see text "NAB Path" displayed
    And I scroll "down" the page
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
      | SearchKeywordInput | <searchNone> |
    And I hit Enter
    And I wait for "1000" milliseconds
    And I "click" row "1" of table "Main"
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
      | Fields             | Value        |
      | SearchKeywordInput | <searchWord> |
    And I hit Enter
    And I wait for "1000" milliseconds
    And I "click" row "1" of table "Main"
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
    And I wait for "1000" milliseconds
    Then I click on button with value "No"
    # And I hit Enter
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
    #  Activity is cancelled and is no longer available for display on the Scheduled Activities screens.
    Then I click on button with value "Save"
    And I see text "Successfully Cancelled" displayed

    # The status of the Activity is updated to 'Cancelled'
    Examples: 
      | PortalName | EmailAdmin                    | Password   | item1       | item2 | item3    | item4            | searchCancel | searchWord  | searchNone  | searchScheduled | CancelReason                                                                                                                                                                              |
      | Bridge     | wenzil.admin@dbresults.com.au | WOsdrdoTlO | Date / Time | Name  | Supplier | Available Spaces | BapaTest     | someautoDNT | NoneautoDNT | someauto        | The cancellation reason is a mandatory free text max 125 characters reason for cancellation. The cancellation reason is a mandatory free text max 125 characters reason for cancellation. |
