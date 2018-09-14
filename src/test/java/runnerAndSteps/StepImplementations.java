package runnerAndSteps;

import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Driver;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import static org.junit.Assert.assertThat;
import static org.hamcrest.CoreMatchers.containsString;
import org.apache.http.HttpStatus;
import org.apache.log4j.xml.DOMConfigurator;
import org.json.JSONException;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.Platform;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxBinary;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.Select;

import com.jayway.restassured.http.ContentType;

import Utilities.DBUtilities;
import Utilities.HomePage;

import static com.jayway.restassured.RestAssured.given;

import cucumber.api.DataTable;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import io.github.bonigarcia.wdm.FirefoxDriverManager;

public class StepImplementations extends BrowserInstance {
	// ********************************************** following is before and
	// after *****************************************
	protected WebDriver driver = BrowserInstance.driver();

	@After()
	public void tearDown() {
		driver.quit();
	}

	private String bolt;
	static String CapturedValue;
	private static final Logger Log = Logger.getLogger(StepImplementations.class.getName());
	public static String APIName;

	// all WCAG stuff
	static String Capture;
	static String sourceCode;
	static String URLCaptured;
	final String wcag_subdirectory = "wcagoutput";
	final String screenshot_subdirectory = "screenshots";
	BROWSER browser_type = BROWSER.CHROME; // change this to change what browser
											// is used
	Hashtable<String, Integer> summary = new Hashtable<String, Integer>();

	public void logit() {
		DOMConfigurator.configure("log4j.xml");
	}

	// ******************************************************************************

	@Given("^I adjust the zoom to \"(.*?)\"$")
	public void i_adjust_the_zoom_to(String arg1) throws Throwable {
		// Set up the zoom level....only use if required//

		JavascriptExecutor executor = (JavascriptExecutor) driver;
		executor.executeScript("document.body.style.zoom = '0.9'");
	}

	@Given("^I check if password is accepted$")
	public void i_check_if_password_is_accepted() throws Throwable {

		try {

			if (driver.getPageSource().contains("Your email address or password is incorrect, please try again.")) { 

				String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class)
						.xpathMakerByTextInClass("caret");
				WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
				exist.click();
				String txtToBeClicked2 = PageFactory.initElements(driver, DBUtilities.class).xpathMaker("SecutityLink");
				WebElement exist2 = driver.findElement(By.xpath(txtToBeClicked));
				exist.click();

			} else {
				Log.info("password accepted ...nothing to do");
			}

		} catch (Exception | AssertionError e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Given("^I query interface \"(.*)?\"$")
	public void I_query_movie_by_title(String arg1) throws UnsupportedEncodingException {

		Log.info("Logging into " + arg1);
	}

	@When("^I make the rest call to \"(.*)?\"$")
	public void I_make_the_rest_call(String arg1) throws IOException, JSONException {
		this.APIName = arg1;

		try {
			given().when().get(arg1).then().statusCode(200);
			given().when().get(arg1).then().assertThat().statusCode(HttpStatus.SC_OK);

		} catch (Exception e) {
			Log.warning("Can not reach interface*******************************");
		}

	}

	@Then("^response should contain \"(.+)\"")
	public void response_should_contain(String expecgted_json_str) throws JSONException {

		String resp = given().accept(ContentType.JSON).when().get(this.APIName).thenReturn().body().asString();
		System.out.println(resp);
	}

	@Given("^I am testing story \"(.*?)\"$")
	public void i_am_test_story(String arg1) throws JSONException {

		Log.info("Now testing story " + arg1);
	}

	@Given("^I paste \"(.*?)\" value in \"(.*?)\"$")
	public void i_paste_value_in(String arg1, String arg2) throws Throwable {

		DBUtilities createXpath = new DBUtilities(driver);
		String myXpath = createXpath.xpathMakerById(arg2);
		Log.info("entering value in search field " + myXpath);
		// driver.findElement(By.xpath(myXpath)).click();
		System.out.println(StepImplementations.CapturedValue);

		driver.findElement(By.xpath(myXpath)).sendKeys(StepImplementations.CapturedValue);
		

	}

	@And("^I take a \"(.*?)\" of row \"(.*?)\" from the table \"(.*?)\"$")
	public void i_capture_from_the_table(String arg1, String arg2, String arg3) throws Throwable {
		if (arg1.equals("click")) {
			String myxpath = new DBUtilities(driver).xPathMakerForReadSomeRowOfSomeTable(arg2, arg3);
			WebElement rowToBeClicked = driver.findElement(By.xpath(myxpath));
			rowToBeClicked.click();
		} else if (arg1.equals("capture")) {
			String myxpath = new DBUtilities(driver).xPathMakerForReadSomeRowOfSomeTable(arg2, arg3);
			System.out.println("DEaling with table element " + myxpath);
			WebElement rowToBeCaptured = driver.findElement(By.xpath(myxpath));
			String captureElement = rowToBeCaptured.getText();
			System.out.println(captureElement);
			// this is specific case , change if required
			if (arg3.equals("DisputesTable")) {
				Capture = captureElement.substring(10, 18);
				System.out.println(Capture);
				if (arg2.equals("ACAT")) {
					Capture = captureElement.substring(19, 26);
					System.out.println(Capture);
				}
			} else {
				Capture = captureElement.substring(0, 7);
			}

		}
	}

	@Then("^I take a \"(.*?)\" of \"(.*?)\" element of row \"(.*?)\" from the table \"(.*?)\"$")
	public void i_take_a_of_element_of_row_from_the_table(String arg1, int arg2, int arg3, String arg4)
			throws Throwable {
		if (arg1.equals("capture")) {
			String myxpath = new DBUtilities(driver).xPathMakerForSomeElementOfSomeRowOfSomeTable(arg2, arg3, arg4);
			System.out.println("DEaling with table element " + myxpath);
			WebElement elementToBeCaptured = driver.findElement(By.xpath(myxpath));
			String captureElement = elementToBeCaptured.getText();
			Capture = captureElement;
			System.out.println(captureElement);

		} else {
			String myxpath = new DBUtilities(driver).xPathMakerForSomeElementOfSomeRowOfSomeTable(arg2, arg3, arg4);
			System.out.println("DEaling with table element " + myxpath);
			WebElement xyz = driver.findElement(By.xpath(myxpath));
			Actions act = new Actions(driver);
			// will click on Bulls eye
			act.moveToElement(xyz, 10, 25).click().build().perform();
			// xyz.click();
		}

	}

	@And("^I capture \"(.*?)\"$")
	public String i_capture(String arg1) throws Throwable {
		Thread.sleep(1000);
		if (arg1.equals("html")) {
			sourceCode = driver.getPageSource();
			URLCaptured = driver.getCurrentUrl();
			if (!sourceCode.startsWith("<!DOCTYPE html>")) {
				sourceCode = "<!DOCTYPE html>\n" + sourceCode;
			}
		} else if (arg1.equals("You have successfully raised Bond")) { // used
																		// for
																		// RB
																		// to
																		// capture
																		// Bond
																		// ID
																		// in
																		// string
			DBUtilities createXpath = new DBUtilities(driver);
			String myxpath = createXpath.xpathMakerContainsText(arg1);
			WebElement xyz = driver.findElement(By.xpath(myxpath));
			String GetBondId = xyz.getText();
			Capture = GetBondId.substring(36, 43);
			System.out.println("*****************************FINAL RESULTS*****************************" + Capture);
		} else {
			DBUtilities createXpath = new DBUtilities(driver);
			// *[@id='38']
			// String myxpath = createXpath.xpathMakerByExactId(arg1);
			String myxpath = createXpath.xpathMakerById(arg1);
			System.out.println(myxpath);
			WebElement xyz = driver.findElement(By.xpath(myxpath));
			xyz.click();
			Capture = xyz.getText();
			System.out.println("&&&" + Capture);
		}
		Thread.sleep(5000);
		return Capture;

	}

	@Given("^I write \"(.*?)\" information to file")
	public void i_write_information_to_file(String arg1) throws Throwable {

		// date format for timestamp in the filenames
		// DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd
		// HH\ua789mm\ua789ss");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String currentDate = dateFormat.format(cal.getTime());
		String outputText = driver.findElement(By.xpath("//*[contains(@id, 'output_div')]")).getText();
		String lineSeparate = "-------------------------------------------------------------------------------------------";
		try {
			// write information to both files
			if (Integer.parseInt(Capture) > 0) {
				PrintWriter pwsource = new PrintWriter(wcag_subdirectory + "/" + arg1 + " SOURCE CODE.html", "UTF-16");
				pwsource.write(sourceCode);
				pwsource.close();
			}
			PrintWriter pwinfo = new PrintWriter(wcag_subdirectory + "/" + arg1 + " WCAG EVALUATION.txt", "UTF-16");
			pwinfo.write("URL: " + URLCaptured);
			pwinfo.write("\n" + lineSeparate + "\n NUMBER OF ERRORS \n" + lineSeparate + "\n");
			pwinfo.write(Capture);
			pwinfo.write("\n" + lineSeparate + "\n OUTPUT TEXT \n" + lineSeparate + "\n");
			pwinfo.write(outputText);
			pwinfo.write(
					"\n\n\n(NUMBER OF 'COLUMN's in the OUTPUT TEXT should equal the NUMBER OF ERRORS. If not, contact Chris Tang for assistance and bugfixing.)");

			pwinfo.close();

		} catch (IOException e) {
			e.printStackTrace();
		}

		summary.put(arg1, Integer.parseInt(Capture));

	}

	// ******************************************* UI
	// *************************************************************
	@Given("^I want to login to portal \"(.*?)\"$")
	public void i_want_to_login_to_the_portal(String arg1) throws Throwable {
		Log.info("logging into portal");
		HomePage home = PageFactory.initElements(driver, HomePage.class);
		home.navigateTo(arg1);

	}

	@Then("^I wait for \"(.*?)\" milliseconds$")
	public void i_wait_for_millisecond(long arg1) throws Throwable {
		Thread.sleep(arg1);

	}

	@Given("^I enter the details as$")
	public void i_enter_the_details_as(DataTable table) {
		try {
			PageFactory.initElements(driver, DBUtilities.class).enterCucumbertableValuesInUI(table);
		} catch (InterruptedException e) {

			e.printStackTrace();
		}

	}

	@Then("^I enter \"(.*?)\" with the current date prepended into \"(.*?)\"$")
	public void i_enter_with_the_current_date_appended_into(String arg1, String arg2) throws Throwable {
		DBUtilities util = new DBUtilities(driver);

		String inputText = arg1;
		String myXpath = util.xpathMakerByInputId(arg2);
		try {
			WebElement elementToClear = driver.findElement(By.xpath(myXpath));
			// String content = elementToClear.
//			int length = elementToClear.getText().length();
//			System.out.println(length);
			elementToClear.click();
			Actions action = new Actions(driver);
			for (int i = 0; i < 10; i++) {
				action.sendKeys(Keys.ARROW_LEFT);
			}
			action.build().perform();

			for (int i = 0; i < 10; i++) {
				action.sendKeys(Keys.BACK_SPACE);
			}
			Thread.sleep(1000);
			action.build().perform();
			elementToClear.clear();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Cannot find an input field! Now trying to find a textarea field...");
//			myXpath = util.xpathMakerByTextAreaId(arg2);
//			WebElement elementToClear = driver.findElement(By.xpath(myXpath));
//			elementToClear.click();
//			elementToClear.clear();
		}
		driver.findElement(By.xpath(myXpath)).sendKeys(inputText);
	}

	// enter future or past dates
	@Given("^I enter \"(.*?)\" date as a \"(.*?)\" date in \"(.*?)\"$")
	public void i_enter_date_as_a_date_in(String arg1, String arg2, String arg3) throws Throwable {
		DBUtilities util = new DBUtilities(driver);
		String inputDate = arg1;
		String myXpath = util.xpathMakerByInputId(arg3);
		String futureORpast = arg3;
		try {
			WebElement elementToClear = driver.findElement(By.xpath(myXpath));

			elementToClear.click();
			Actions action = new Actions(driver);
			for (int i = 0; i < 10; i++) {
				action.sendKeys(Keys.ARROW_LEFT);
			}
			action.build().perform();

			for (int i = 0; i < 10; i++) {
				action.sendKeys(Keys.BACK_SPACE);
			}
			Thread.sleep(1000);
			action.build().perform();
			elementToClear.clear();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Cannot find an input field! Now trying to find a textarea field...");
			myXpath = util.xpathMakerByTextAreaId(arg2);
			WebElement elementToClear = driver.findElement(By.xpath(myXpath));
			elementToClear.click();
			elementToClear.clear();
		}
		if (arg2.equals("future")) {
			DBUtilities tomorowDate = new DBUtilities(driver);
			String dateToEnter = tomorowDate.futureDate();
			System.out.println(dateToEnter);
			driver.findElement(By.xpath(myXpath)).sendKeys(dateToEnter);

			// increase date by 1 day
		}
	}

	@Given("^I check I am on \"(.*?)\" page$")
	public void i_check_I_am_on_page(String arg1) {
		try {
			PageFactory.initElements(driver, HomePage.class).checkIfOnRightPage(arg1);

			Log.info("Landed on the right page " + arg1);
		} catch (Exception e) {
			Log.warning("Not landed on  *******************************" + arg1);
		}
	}

	@And("^I hit Enter$")
	public DBUtilities I_hit_Enter() throws InterruptedException {
		PageFactory.initElements(driver, DBUtilities.class).hitEnter();
		Log.info("hitting Enter");

		Thread.sleep(2000);
		return PageFactory.initElements(driver, DBUtilities.class);

	}

	@Then("^I check \"(.*?)\" contains maximum length of \"(.*?)\"$")
	public void i_check_contains_maximum_length_of(String arg1, int arg2) throws Throwable {

		PageFactory.initElements(driver, HomePage.class).checkMaxLength(arg1, arg2);

	}

	@Then("^I verify sorting is working for \"(.*?)\" table column \"(.*?)\"$")
	public void i_verify_sorting_is_working_for_column(String arg1, int arg2) throws Throwable {
		String toSort = PageFactory.initElements(driver, DBUtilities.class).sortingCheck(arg1, arg2);
		System.out.println(toSort.compareTo(arg1));
	}

	@Then("^\"(.*?)\" is displayed as \"(.*?)\"$")
	public void is_displayed_as(String arg1, String arg2, DataTable table) throws InterruptedException {

		PageFactory.initElements(driver, DBUtilities.class).checkElementPresentOnScreen(table);

	}

	@Then("^I see text \"(.*?)\" not displayed$")
	public void i_see_text_not_displayed(String arg1) throws Throwable {

		DBUtilities createXpath = new DBUtilities(driver);
		createXpath.checkTextElementAbsent(arg1);

	}

	@Then("^I see text \"(.*?)\" displayed$")
	public void i_see_text_displayed(String arg1) throws Throwable {
		// LandingPage AU = PageFactory.initElements(driver, LandingPage.class);

		DBUtilities checkElementDisplayed = new DBUtilities(driver);

		checkElementDisplayed.checkTextElementPresent(arg1);

	}

	@Then("^I click on text \"(.*?)\"$")
	public void i_click_on_text(String arg1) throws Throwable {
		if (arg1.equals("Users")) {
			String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class).xpathMaker(arg1);
			WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
			Log.info("clicking on " + exist);
			exist.click();
			// this is just add comment
		} else if (arg1.equals("forgotten my password") || (arg1.equals("Show All") || (arg1.equals("Hide")))) {
			String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class).xpathMakerContainsText(arg1);
			WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
			exist.click();
		} else if (arg1.equals("Logout") || (arg1.equals("REQUEST REFUND"))) {
			String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class)
					.xpathMakerContainsText2ndOption(arg1);
			WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
			exist.click();
		} else if (arg1.equals("")) {
			System.out.println(" Not expecting element to be present on screen so going to next step");
		} else if (!arg1.equals(""))

		{

			String txtToBeClicked = PageFactory.initElements(driver, DBUtilities.class).xpathMaker(arg1);
			WebElement exist = driver.findElement(By.xpath(txtToBeClicked));
			exist.click();
		}

	}

	@Then("^I click on element with ID \"(.*?)\"$")
	public void i_click_element_with_ID(String arg1) throws Throwable {

		String txtBox = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg1);
		WebElement exist = driver.findElement(By.xpath(txtBox));
		Log.info("clicking on " + exist);
		exist.click();
	}

	@Then("^I check object with xpath \"(.*?)\" contains \"(.*?)\"$")
	public void i_check_object_with_xpath_contains(String arg1, String arg2) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = arg1;
		try {
			WebElement inputBox = driver.findElement(By.xpath(myxpath));
			String contents = inputBox.getText().trim();

			Log.info("Comparing " + contents + " with " + arg2);

			Assert.assertTrue(contents.equals(arg2));
		} catch (Exception | AssertionError e) {
			e.printStackTrace();
		}
	}

	@Then("^I click on image \"(.*?)\"$")
	public void i_click_on_image(String arg1) throws Throwable {
		try {
			driver.manage().timeouts().implicitlyWait(20, TimeUnit.SECONDS);
			DBUtilities createXpath = new DBUtilities(driver);
			String myxpath = createXpath.xpathMakerByImageName(arg1);
			System.out.println(myxpath);
			WebElement exist = driver.findElement(By.xpath(myxpath));
			exist.click();
		} catch (Exception e) {
			System.out.println("Element image not visible on Screen");
		}
	}

	@Then("^I check \"(.*?)\" contains \"(.*?)\"$")
	public void i_Check_contains(String arg1, String arg2) throws Throwable {
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerById(arg1);
		WebElement inputBox = driver.findElement(By.xpath(myxpath));
		String contents = inputBox.getAttribute("value");
		Log.info("Comparing " + contents + " with " + arg2);

		try {
			Assert.assertTrue(contents.equals(arg2));
		} catch (AssertionError | Exception e) {

			e.printStackTrace();
		}

	}

	@And("^I click on button \"(.*?)\"$")
	public void i_click_on_button(String arg1) throws Throwable {
		String myXpath = null;
		DBUtilities createXpath = new DBUtilities(driver);

		if (arg1.equals("")) {
			System.out.println(" Not expecting element to be present on screen so going to next step");

		} else if (arg1.equals("Logout")) {
			myXpath = createXpath.xpathMakerById(arg1);
			List<WebElement> multiElements = driver.findElements(By.xpath(myXpath));
			int numberOfObjects = multiElements.size();

			for (int i = 0; i <= numberOfObjects; i++) {
				int x = multiElements.get(i).getLocation().getX();
				if (x != 0) {
					multiElements.get(i).click();
					break;
				}
			}

		} else {

			try {
				myXpath = createXpath.xpathMakerById(arg1);
				driver.findElement(By.xpath(myXpath)).click();
			} catch (Exception e) {

				if (driver.findElement(By.xpath(myXpath)).isDisplayed()) {
					System.out.println("Element is Present" + myXpath);
				} else {
					System.out.println("Element is Absent SOOOOOO SCROLLING DOWN" + myXpath);
					createXpath.scrollDownForElement(myXpath);
				}
				Thread.sleep(1000);

				driver.findElement(By.xpath(myXpath)).click();

			}
			Thread.sleep(2000);

		}
	}

	@And("^button \"(.*?)\" should not be displayed$")

	public void buttonShouldNotBeDisplayed(String arg1) {
		if (arg1.equals("")) {
			System.out.println(" Not expecting element to be present on screen so going to next step");
		} else if (!arg1.equals("")) {
			DBUtilities createXpath = new DBUtilities(driver);
			createXpath.checkTextElementAbsent(arg1);
		}
	}

	@And("^I click on button with value \"(.*?)\"$")
	public void i_click_on_button_with_value(String arg1) throws Throwable {
		String myXpath = null;
		DBUtilities createXpath = new DBUtilities(driver);
		try {
			myXpath = createXpath.xpathMakerByValue(arg1);
			Log.info("Clicking on element with xpath" + myXpath);
			Actions act = new Actions(driver);
			// will only click on visible element

			act.moveToElement(driver.findElement(By.xpath(myXpath))).click().build().perform();
			// act.click();
		} catch (Exception e) {

			System.out.println("Element is Absent SOOOOOO SCROLLING DOWN" + myXpath);
			createXpath.scrollDownForElement(myXpath);
			myXpath = createXpath.xpathMakerByValue(arg1);
			// driver.findElement(By.xpath(myXpath)).click();
			Actions act = new Actions(driver);
			// will only click on visible element
			act.moveToElement(driver.findElement(By.xpath(myXpath))).click().build().perform();

		}
		Thread.sleep(1000);

	}

	@Then("^I see \"(.*?)\" displayed on popup and I click \"(.*?)\"$")
	public void i_see_displayed_on_popup_and_I_click(String arg1, String arg2) throws Throwable {
		// Thread.sleep(3000);
		PageFactory.initElements(driver, DBUtilities.class).checkPopUpMessage(arg1, browser_type);
		PageFactory.initElements(driver, DBUtilities.class).clickOnPopUP(arg2);
		Thread.sleep(2000);
	}

	@Then("^I check \"(.*?)\" is empty$")
	public void i_check_is_empty(String arg1) throws Throwable {
		String myxpath = new DBUtilities(driver).xpathMakerById(arg1);
		WebElement inputBox = driver.findElement(By.xpath(myxpath));
		Assert.assertTrue(inputBox.isDisplayed());
		String boxContents = inputBox.getAttribute("value");
		try {
			Assert.assertTrue(boxContents.isEmpty());
		}
		// in the
		catch (Exception e) {
			Assert.assertTrue(boxContents == null);
		}
	}

	// wrong step......dont hard code
	@Then("^I click on object with xpath \"(.*?)\"$")
	public void i_click_on_object_with_xpath(String arg1) throws Throwable {
		try {
			WebElement object = driver.findElement(By.xpath(arg1));
			object.click();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Then("^I check \"(.*?)\" exists$")
	public void i_check_exists(String arg1) throws Throwable {
		DBUtilities checkElementDisplayed = new DBUtilities(driver);

		String myxpath = checkElementDisplayed.xpathMakerByInputId(arg1);
		WebElement object = driver.findElement(By.xpath(myxpath));
		Assert.assertTrue(object.isDisplayed());

	}

	// for those Outsystems popups, set argument as 0 or 1 if there is only one
	// frame present
	@Then("^I switch to frame \"(.*?)\"$")
	public void i_switch_to_frame(String arg1) throws Throwable {
		int frameNum = Integer.parseInt(arg1);
		driver.switchTo().frame(frameNum);
		System.out.println("I am here");
	}

	@Then("^I clear \"(.*?)\" of content$")
	public void i_clear_of_content(String arg1) throws Throwable {
		DBUtilities checkElementDisplayed = new DBUtilities(driver);
		try {
			String myxpath = checkElementDisplayed.xpathMakerById(arg1);
			WebElement object = driver.findElement(By.xpath(myxpath));
			object.clear();
		} catch (Exception e) {
			String myxpath = checkElementDisplayed.xpathMakerByClass(arg1);
			WebElement object = driver.findElement(By.xpath(myxpath));
			object.clear();
		}
	}

	@Then("^I check \"(.*?)\" is readonly$")
	public void i_check_is(String arg1) throws Throwable {
		PageFactory.initElements(driver, DBUtilities.class).elementIsreadOnly(arg1);
	}

	@Then("^I see popup \"(.*?)\" displayed$")
	public void i_see_popup_displayed(String arg1) throws Throwable {

		DBUtilities createXpath = new DBUtilities(driver);
		createXpath.xpathMakerByTextInClass(arg1);
	}

	@Given("^I enter popup values as$")
	public void i_enter_popup_values_as(DataTable table) throws Throwable {
		PageFactory.initElements(driver, DBUtilities.class).enterCucumbertableValuesInUI(table);

	}

	@And("^I click on \"(.*?)\" on popup$")
	public void i_click_on_popup(String arg1) throws Throwable {
		// give time for page loading
		DBUtilities createXpath = new DBUtilities(driver);
		String myxpath = createXpath.xpathMakerByValue(arg1);
		System.out.println("dededed");
		driver.findElement(By.xpath(myxpath)).click();

	}

	@And("^I select \"(.*?)\" from \"(.*?)\"$")
	public void i_select_from(String arg1, String arg2) throws Throwable {

		// following is RB special
		if (arg1.isEmpty()) {
			Log.info("Element is not expected to appear on screen");
		} else if (arg1.equals("Virtual") || arg1.equals("Agent Administrator") || arg1.equals("RBU Team Leader")
				|| arg1.equals("RBU Officer") || arg1.equals("Virtual") || arg1.equals("Agency Admin")
				|| arg1.equals("Globex Corporation")) {
			String myxpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerContainsText1stOption(arg1);
			String myxpath2 = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg2);
			System.out.println(" looking for dropdown xpath " + myxpath);
			driver.findElement(By.xpath(myxpath2)).click();
			Thread.sleep(1000);
			driver.findElement(By.xpath(myxpath)).click();
		} else {
			String myxpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerDivContainsText(arg1);
			String myxpath2 = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg2);
			System.out.println(" looking for dropdown xpath " + myxpath);
			driver.findElement(By.xpath(myxpath2)).click();
			Thread.sleep(1000);
			driver.findElement(By.xpath(myxpath)).click();

		}

	}

	@Then("^I enter a application specific time in \"(.*?)\"$")
	public void i_enter_a_application_specific_time_in(String arg1) throws Throwable {
		if (arg1.equals("EndHour")) {
			// read value
			DBUtilities createXpath = new DBUtilities(driver);
			String myxpath = createXpath.xpathMakerById(arg1);

			Select select = new Select(driver.findElement(By.xpath(myxpath)));
			WebElement option = select.getFirstSelectedOption();
			String defaultItem = option.getText();
			System.out.println(defaultItem);
			// converting to int

			int toInt = Integer.parseInt(defaultItem);
			int timeToEnter = toInt + 1;
			driver.findElement(By.xpath(myxpath)).sendKeys(String.valueOf(timeToEnter));

		}
	}

	@And("^I select option \"(.*?)\" from \"(.*?)\"$")
	public void i_select_option_from(String arg1, String arg2) throws Throwable {

		// following is RB special
		if (arg1.isEmpty()) {
			Log.info("Element is not expected to appear on screen");
		} else if (arg1.equals("AgeRange") || arg1.equals("Agent Administrator") || arg1.equals("ADS")
				|| arg1.equals("RBU Officer") || arg1.equals("Housing Officer") || arg1.equals("Agency Admin")) {
			String myxpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerContainsText1stOption(arg1);
			String myxpath2 = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg2);
			System.out.println(" looking for dropdown xpath " + myxpath);
			driver.findElement(By.xpath(myxpath2)).click();
			Thread.sleep(1000);
			driver.findElement(By.xpath(myxpath)).click();
		} else {
			if (arg2.equals("EndHour")) {
				String myxpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerByOptionValue(arg1);
				String myxpath2 = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg2);
				System.out.println(" looking for dropdown xpath " + myxpath);
				driver.findElement(By.xpath(myxpath2)).click();
			}
			String myxpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerByOptionValue(arg1);
			String myxpath2 = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg2);
			System.out.println(" looking for dropdown xpath " + myxpath);
			driver.findElement(By.xpath(myxpath2)).click();
			Thread.sleep(1000);
			driver.findElement(By.xpath(myxpath)).click();
		}

	}

	@Then("^I see \"(.*?)\" element \"(.*?)\" displayed$")
	public void i_see_element_displayed(String arg1, String arg2, DataTable table) throws Throwable {
		List<List<String>> data = table.raw();

		for (int i = 1; i < data.size(); i++) {
			String name = data.get(i).get(1);
			System.out.println("The table length is .." + data.size());

			DBUtilities createXpath = new DBUtilities(driver);

			createXpath.checkUIElementTEXTIsDisplayed(name);
		}
	}

	// this is for checking checkbox
	@Given("^I click on \"(.*?)\" checkbox$")
	public void i_click_on_checkbox(String arg1) throws Throwable {

		PageFactory.initElements(driver, DBUtilities.class).checkBoxClick(arg1);

	}

	@Then("^I see \"(.*?)\" is in \"(.*?)\" field and \"(.*?)\" is displayed as \"(.*?)\" in the row$")
	public void i_see_is_in_field_and_is_displayed_as(String arg1, String arg2, String arg3, String arg4,
			DataTable table) throws Throwable {
		PageFactory.initElements(driver, DBUtilities.class).checkRowValuesOrder(arg2, arg1, table);
	}

	@Then("^I \"(.*?)\" text \"(.*?)\" displayed in table \"(.*?)\"$")
	public void i_should_see_displayed_in_table(String arg1, String arg2, String arg3) throws Throwable {

		if (arg2.equals("selectTheFirstRow")) {
			DBUtilities createXpath = new DBUtilities(driver);
			String checkFirstRowInTable = createXpath.xPathMakerForReadSomeRowOfSomeTable(arg2, arg3);
			// for a change putting double click
			driver.findElement(By.xpath(checkFirstRowInTable)).click();

		} else {

			if (arg1.equals("check")) {
				String checkElementInTable = PageFactory.initElements(driver, DBUtilities.class)
						.xpathMakerPickTrTextInTableID(arg2, arg3);
				// Assert.assertEquals(true, checkElementInTable.isDisplayed());
				Assert.assertTrue(driver.findElement(By.xpath(checkElementInTable)).isDisplayed());

			} else if (arg1.equals("click")) {

				if (arg2.equals("CheckBox")) {

					// hard coded for now but need to resolve this later
					String checkBoxToClick = PageFactory.initElements(driver, DBUtilities.class)
							.xpathMakerByInputId("ctl00_wtCBSupplier");
					WebElement element = driver.findElement(By.xpath(checkBoxToClick));
					element.click();

				} else {

					DBUtilities createXpath = new DBUtilities(driver);
					String checkElementInTable = createXpath.xpathMakerPickTrTextInTableID(arg2, arg3);
					System.out.println("clicking on table element " + arg1);
					driver.findElement(By.xpath(checkElementInTable)).click();

				}
			}
		}
	}

	// Then I check that table ARG with row containing ARG2 has the following

	@Then("^I check that table \"(.*?)\" with row containing \"(.*?)\" has the following$")
	public void i_should_see_displayed_in_table(String arg1, String arg2, DataTable table) throws Throwable {

		String tableXpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerPickTrTextInTableID(arg2,
				arg1);
		String rowContent = driver.findElements(By.xpath(tableXpath)).get(0).getText();
		System.out.println(rowContent);
		List<List<String>> tableData = table.raw();
		// List<String> rowContentList = Arrays.asList(rowContent.split("\n"));

		for (int i = 1; i < tableData.size(); i++) {
			String data = tableData.get(i).get(1);
			System.out.println("Checking for " + data);

			try {
				assertThat(rowContent, containsString(data));

			} catch (Exception e) {

				Log.info("Not found" + data);
			}
			// this step will click on table elements that generate popups, for
			// some reason
			// use this to refresh the page and make the popups disappear
			driver.navigate().refresh();

		}

	}

	@Then("^I \"(.*?)\" table \"(.*?)\" exist and row \"(.*?)\" containing image \"(.*?)\"$")
	public void i_table_exist_and_row_containing_image(String arg1, String arg2, int arg3, String arg4)
			throws Throwable {

		try {
			String tableXpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerPickRowNoWithImage(arg2,
					arg3, arg4);

			WebElement element = driver.findElement(By.xpath(tableXpath));
			Assert.assertTrue(element.isDisplayed());
			System.out.println(tableXpath);

			if (arg1.equals("click"))
				element.click();
			else {
				System.out.println("Element exixt is row");
			}
		}
		// in the
		catch (Exception e) {
			System.out.println("No row is displayed");
		}
	}

	@Then("^I check that table \"(.*?)\" with row containing \"(.*?)\" returns atleast \"(.*?)\" row$")
	public void i_check_that_table_with_row_containing_returns_atleast_row(String arg1, String arg2, String arg3)
			throws Throwable {

		String tableRow = PageFactory.initElements(driver, DBUtilities.class).xpathMakerCountRowsOfTable(arg1, arg3);

		System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%% rowContent" + tableRow);
		WebElement elementToBeClicked = driver.findElement(By.xpath(tableRow));

		try {
			Assert.assertTrue(elementToBeClicked.isDisplayed());
		}
		// in the
		catch (Exception e) {
			System.out.println("No row is displayed");
		}
	}

	// select some row of some table
	@Then("^I \"(.*?)\" row \"(.*?)\" of table \"(.*?)\"$")
	public void i_row_of_table(String arg1, String arg2, String arg3) throws Throwable {
		if (arg1.equals("click")) {
			String tableRow = PageFactory.initElements(driver, DBUtilities.class).xpathMakerSomeRowInTable(arg3, arg2);

			// String tableRow = PageFactory.initElements(driver,
			// DBUtilities.class).xpathMakerPickFirstRowInTable(arg2,arg3);
			System.out.println("$$$$$$$$$ " + tableRow);

			WebElement elementToBeClicked = driver.findElement(By.xpath(tableRow));
			try {
				Assert.assertTrue(elementToBeClicked.isDisplayed());
				elementToBeClicked.click();
			}

			catch (Exception e) {
				System.out.println("ERROR $$$ No element with xpath " + tableRow + "is displayed");
			}
		}

	}

	@Then("^I click on \"(.*?)\" radio option$")
	public void i_click_on_radio_option(String arg1) throws Throwable {

		// following is for Gessit only.....because of poor coding practice
		String myxpath = PageFactory.initElements(driver, DBUtilities.class).xpathMakerById(arg1);
		// for overlapping

		// myXpath = createXpath.xpathMakerById(arg1);
		WebElement elementToBeClicked = driver.findElement(By.xpath(myxpath));

		try {
			Thread.sleep(1000);
			elementToBeClicked.click();
		} catch (Exception e) {
			Actions actions = new Actions(driver);
			Thread.sleep(1000);
			actions.keyDown(Keys.CONTROL).sendKeys(Keys.END).perform();
			Thread.sleep(1000);
			elementToBeClicked.click();
		}

	}

	@Given("^I capture text \"(.*?)\"$")
	public String i_capture_someValue(String arg1) throws Throwable {

		DBUtilities createXpath = new DBUtilities(driver);

		String myxpath = createXpath.xpathMakerById(arg1);
		StepImplementations.CapturedValue = driver.findElement(By.xpath(myxpath)).getAttribute("value");
		System.out.println("object that is captured is *****************>>>>>>>>>>>>>>>>>>>>>>>> " + CapturedValue);

		return CapturedValue;

	}

	// added 27.03.2018 WP
	@And("^I scroll \"(.*?)\" the page$")
	public void i_scroll_the_page(String arg1) throws Throwable {
		// new DBUtilities(driver).scrollDownThePage(arg1);
		PageFactory.initElements(driver, DBUtilities.class).scrollDownThePage(arg1);
	}

	// following is temp
	@When("^I click on checkbox with id \"(.*?)\"$")
	public void i_click_on_checkbox_with_id(String arg1) throws Throwable {
		PageFactory.initElements(driver, DBUtilities.class).xpathMakerByExactId(arg1);
	}

	@Then("^I see text \"(.*?)\" not displayed in \"(.*?)\"$")
	public void i_see_text_not_displayed_in(String arg1, String arg2) throws Throwable {
		PageFactory.initElements(driver, DBUtilities.class).checkTextElementAbsent(arg2);
	}

	@Then("^I upload a \"(.*?)\" file$")
	public void i_upload_a_file(String arg1) throws Throwable {
		PageFactory.initElements(driver, DBUtilities.class).fileUploadFromLocal(arg1);

	}

	@Then("^a new page \"(.*?)\" is launched$")
	public void a_new_page_is_launched(String arg1) throws Throwable {
		String URL = driver.getCurrentUrl();
		System.out.println(URL);
		new DBUtilities(driver).passControlToNewWindow(arg1);

	}

}
