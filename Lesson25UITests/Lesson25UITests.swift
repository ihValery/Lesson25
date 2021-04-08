import XCTest
@testable import Lesson25

class Lesson25UITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.isOnMainView)
        
        app.navigationBars["Lesson25.TaskListView"].buttons["Add"].tap()
        app.textFields["Title"].tap()
        app.textFields["Title"].typeText("Foo")
        
        app.textFields["Description"].tap()
        app.textFields["Description"].typeText("Bar")
        
        app.textFields["Location"].tap()
        app.textFields["Location"].typeText("Baz")
        
        app.textFields["Date"].tap()
        app.textFields["Date"].typeText("08.04.21")
        
        app.textFields["Address"].tap()
        app.textFields["Address"].typeText("Minsk")
        
        XCTAssertFalse(app.isOnMainView)
        app.buttons["Save"].tap()
        
//        XCTAssertTrue(app.tables.staticTexts["Bar"].exists)
    }
    
    func testEhenCellIsSwipedLeftDoneButtonAppeared() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.isOnMainView)

        app.navigationBars["Lesson25.TaskListView"].buttons["Add"].tap()
        app.textFields["Title"].tap()
        app.textFields["Title"].typeText("Foo")

        app.textFields["Description"].tap()
        app.textFields["Description"].typeText("Bar")

        app.textFields["Location"].tap()
        app.textFields["Location"].typeText("Baz")

        app.textFields["Date"].tap()
        app.textFields["Date"].typeText("08.04.21")

        app.textFields["Address"].tap()
        app.textFields["Address"].typeText("Minsk")

        XCTAssertFalse(app.isOnMainView)
        app.buttons["Save"].tap()
        
        XCTAssertTrue(app.isOnMainView)
        
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Done"].tap()
        
//        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "date").label, "")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIApplication {
    
    var isOnMainView: Bool {
        return otherElements["mainView"].exists
    }
}
