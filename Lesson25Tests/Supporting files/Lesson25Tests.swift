import XCTest
@testable import Lesson25

class Lesson25Tests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
        
    }

    override func tearDownWithError() throws {
        
        super.tearDown()
    }

    func testInitialViewCOntrollerIsTaskListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navigationController.viewControllers.first as! TaskListViewController
        
        XCTAssertTrue(rootViewController is TaskListViewController)
    }
    
//    func <#name#>(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
}
