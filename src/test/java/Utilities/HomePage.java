package Utilities;

import java.util.logging.Logger;

import org.openqa.selenium.WebDriver;

import runnerAndSteps.StepImplementations;


public class HomePage extends DBUtilities  {

	Assertions assertions = new Assertions(driver);
	private static final Logger log = Logger.getLogger(StepImplementations.class.getName());
	public HomePage(WebDriver driver)
	{
		 super(driver);
	}
	public void navigateTo(String arg1) {
		if (arg1.equals("Bridge")) { 
				driver.get("https://qa.nabthebridge.randstad.com.au/");
		
				assertions.valueDisplyedMeetsExpectedValue("https://qa.nabthebridge.randstad.com.au/");

		}
		
		else if(arg1.equals("BridgeDev")){
			driver.get("https://dev-os.randstad.com.au/TBAccountManagement/Login.aspx");
		}
		
		else if(arg1.equals("AC CHECKER")){
			driver.get("http://achecker.ca/checker/index.php");
		}
	
		else if(arg1.equals("PasswordReset")){
			driver.get("https://qa-os.randstad.com.au/TBAccountManagement/Login.aspx?(Not.Licensed.For.Production)=");
		}
		else if(arg1.equals("BridgeSearch")){
			driver.get("https://dev-os.randstad.com.au/TBAccountManagement/Search.aspx");
		}
	}
}
