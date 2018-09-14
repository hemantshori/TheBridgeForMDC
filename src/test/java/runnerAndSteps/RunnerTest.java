package runnerAndSteps;

import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;

// This is Runner and the tests will be run from here......Right click and Run as Junit tests
@RunWith(Cucumber.class)
@CucumberOptions

// ************************************** TheBridge Portal as on 14/03/2018




(format = { "pretty", "html:target/html/result.html" }, tags = { "@wip" },
	


//****************for WIP****************************
//features = "src/test/resource/com/DBResults/TheBridge/wip.feature")
features = "src/test/resource/com/DBResults/TheBridge/Iteration3.feature")




public class RunnerTest {

}



