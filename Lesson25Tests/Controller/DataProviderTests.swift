import XCTest
@testable import Lesson25

class DataProviderTests: XCTestCase {
    
    var sut: DataProvider!
    var tableView: UITableView!
    
    //Что бы получить tableView со storyboarda
    var controller: TaskListViewController!

    override func setUpWithError() throws {
        super.setUp()
        sut = DataProvider()
        sut.taskManager = TaskManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(identifier: "TaskListViewController") as? TaskListViewController
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
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
    
    func testCellForRowAtIndexPathDequeuesCellFromTableView() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        
        mockTableView.register(TaskCell.self, forCellReuseIdentifier: "taskCell")
        sut.taskManager?.add(task: Task(title: "Foo"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellIsDequeued)
    }
    
    //Проверка срабатывает ли в нулевой секции метод configure(withTask task: Task)
    func testCellForRowsInSectionZeroCallsConfigure() {
        tableView.register(MockTaskCell.self, forCellReuseIdentifier: "taskCell")
        
        let taskForTest = Task(title: "Foo")
        sut.taskManager?.add(task: taskForTest)
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockTaskCell
        
        XCTAssertEqual(cell.task, taskForTest)
    }
    
    func testCellForRowsInSectionOneCallsConfigure() {
        tableView.register(MockTaskCell.self, forCellReuseIdentifier: "taskCell")
        
        let taskForTest = Task(title: "Foo")
        sut.taskManager?.add(task: taskForTest)
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockTaskCell
        
        XCTAssertEqual(cell.task, taskForTest)
    }
}

extension DataProviderTests {
    //Здесь класс, что бы ограничеть его облать видимости
    //Подменим наш tableView - MockTableView со свойством которое подскажет переиспользуем cell или нет
    class MockTableView: UITableView {
        //Исключен из очереди(Переиспользуется)
        var cellIsDequeued = false
        
        //Удалить из очереди многоразовую ячейку
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class MockTaskCell: TaskCell {
        
        var task: Task?
        
        override func configure(withTask task: Task) {
            self.task = task
        }
    }
}
