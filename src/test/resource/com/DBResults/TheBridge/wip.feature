


Feature: Iteration1Tests
@wip
  Scenario Outline: TB-9:As a Participant/Supplier/Admin, I want to log out of the portal so that it prevents unauthorised access when I no longer need to use the portal
    # Scenario 1: Participitant User logs out of the portal
    Given I want to login to portal "<PortalName>"
    

    

    Examples: 
      | PortalName | EmailPart              | PasswordPart | EmailSup             | PasswordSup |
      | Bridge     | part1@dbresults.com.au | password1    | ac1@dbresults.com.au | password1   |
   #    | Bridge     | part1@dbresults.com.au | password1    | ac1@dbresults.com.au | password1   |