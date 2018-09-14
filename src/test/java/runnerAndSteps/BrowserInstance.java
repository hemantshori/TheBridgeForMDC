package runnerAndSteps;

import java.io.File;
import java.util.logging.Logger;

import org.junit.After;
import org.junit.Before;
import org.openqa.selenium.Platform;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxBinary;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.firefox.FirefoxProfile;

import io.github.bonigarcia.wdm.FirefoxDriverManager;

public class BrowserInstance {
	
	protected static WebDriver driver;
	private static final Logger Log = Logger.getLogger(StepImplementations.class.getName());
	static BROWSER browser_type = BROWSER.CHROME;
//protected WebDriver getDriver() {
//
//	if(driver==null)
//	{
//		driver= new ChromeDriver();
//	}
//	return driver;
//}


@Before
public static WebDriver driver() {

	Log.info("opening Browser");
	// //+++++++++++++ FOR CHROME ++++++++++++++++++++++++++

	// // following is added to fix chrome maximise issue

	if (browser_type == BROWSER.CHROME) {
		System.setProperty("webdriver.chrome.driver",
				"src/test/java/Drivers/chromedriver.exe");
		ChromeOptions options = new ChromeOptions();
		options.addArguments("test-type");
		options.addArguments("start-maximized");
		options.addArguments("--js-flags=--expose-gc");
		options.addArguments("--enable-precise-memory-info");
		options.addArguments("--disable-popup-blocking");
		options.addArguments("--disable-default-apps");
		options.addArguments("test-type=browser");
		options.addArguments("disable-infobars");

		driver = new ChromeDriver(options);

	} else if (browser_type == BROWSER.FIREFOX) {
		FirefoxDriverManager.getInstance().setup();
		File browserAppPath = null;

		// check if the platform is windows
		if (Platform.getCurrent().is(Platform.WINDOWS)) {
			browserAppPath = new File("C:\\Program Files\\Mozilla Firefox\\firefox.exe");

			// alternative path
			if (!browserAppPath.exists()) {
				browserAppPath = new File("C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe");
			}
		} else {
			// Ubuntu
			browserAppPath = new File("/usr/bin/firefox/firefox-bin");
		}

		FirefoxBinary ffBinary = new FirefoxBinary(browserAppPath);

		// create a binary
		FirefoxProfile firefoxProfile = new FirefoxProfile();
		FirefoxOptions ffo = new FirefoxOptions().setBinary(ffBinary).setProfile(firefoxProfile);
		driver = new FirefoxDriver(ffo);

	}
	return driver;



}


}
