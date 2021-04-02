import XCTest
@testable import Lesson25

class DataProviderTests: XCTestCase {
    
    var sut: DataProvider!
    var tableView: UITableView!

    override func setUpWithError() throws {
        super.setUp()
        sut = DataProvider()
        sut.taskManager = TaskManager()
        
        tableView = UITableView()
        tableView.dataSource = sut
    }

    override func tearDownWithError() throws {
        sut = nil
        tableView = nil
        super.tearDown()
    }
    
    func testNumberOfSectionisTwo() {
        let numberOfSection = tableView.numberOfSections
        XCTAssertTrue(numberOfSection == 2)
    }
    
    func testNumberOfRowsInSectionZeroIsTasksCount() {
        sut.taskManager?.add(task: Task(title: "Foo"))

        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.taskManager?.add(task: Task(title: "Bar"))
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testNumberOfRowsInSectionOneIsTasksDoneCount() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        sut.taskManager?.checkTask(at: 0)

        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.taskManager?.add(task: Task(title: "Bar"))
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()

        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testCellForRowAtIndexPathReturnsTaskCell() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is TaskCell)
    }
}
