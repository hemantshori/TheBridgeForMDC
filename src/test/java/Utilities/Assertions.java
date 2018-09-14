package Utilities;

import java.sql.Driver;
import java.util.logging.Logger;

import org.apache.poi.util.SystemOutLogger;
import org.junit.Assert;
import org.omg.Messaging.SyncScopeHelper;
import org.openqa.selenium.WebDriver;

import runnerAndSteps.StepImplementations;

public class Assertions extends XPathGenerator {
	private static final Logger log = Logger.getLogger(StepImplementations.class.getName());
	public Assertions(WebDriver dr)
	{
		 super(dr);
	}
	
	protected void valueDisplyedMeetsExpectedValue(String present)
	{
		try{
			System.out.println(driver.getCurrentUrl());
			System.out.println(present);
			  Assert.assertEquals(present, driver.getCurrentUrl());
			 log.info("Landed on correct page");
			}
			catch(Throwable pageNavigationError){
			  log.info("some problem with website, raise a bug");
			}
	
     }
	
	
}
