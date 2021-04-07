import XCTest
@testable import Lesson25

class TaskListViewControllerTests: XCTestCase {
    
    var sut: TaskListViewController!

    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //Получаем строку типа TaskListViewController в индетификаторе
        let vc = storyboard.instantiateViewController(identifier: String(describing: TaskListViewController.self))
        sut = vc as? TaskListViewController
        
        //Заставляем сработать метод viewDidLoad
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
        
        /*
        //Обращаясь к view - заставляем сработать метод viewDidLoad
        //_ = sut.view или
        sut.loadViewIfNeeded()
        //Мы работает через storuboard поэтому будет другой код
        */
    func testWhenViewIsLoadedTableViewNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testWhenViewIsLoadedDataProviderIsNotNil() {
        XCTAssertNotNil(sut.dataProvider)
    }
    
    func testWhenViewViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    func testWhenViewViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    //Один и тот же экземпляр?
    func testWhenViewIsLoadedTableViewDelegateEqualsTableViewDataSource() {
        XCTAssertEqual(sut.tableView.delegate as? DataProvider,
                       sut.tableView.dataSource as? DataProvider)
    }
    
    func testTaslListVCHasAddButtonWithSelfAsTarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? TaskListViewController, sut)
    }
    
    func presentingNewTaskViewController() -> InputTaskViewController {
        
        guard let newTaskButton = sut.navigationItem.rightBarButtonItem,
              let action = newTaskButton.action
              else {
            return InputTaskViewController()
        }
        //Добавление sut в качестве rootViewController нашего window
        //Варнинг: Не можем создавать новые контроллеры с контроллера который находиться уже не на экране
        //Так работают только тесты, мол не видим фактически нашего приложения
        UIApplication.shared.keyWindow?.rootViewController = sut
        
        //Попытка выполнить action от кнопки
        sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)

        let newTaskViewController = sut.presentedViewController as! InputTaskViewController
        return newTaskViewController
    }
    
    func testAddNewTaspPresentNewTasViewController() {
        let newTaskViewController = presentingNewTaskViewController()
        XCTAssertNotNil(newTaskViewController.titleTextField)
    }
    
    func testSharesSameTaskManagerwithInputTaskViewController() {
        let newTaskViewController = presentingNewTaskViewController()
        
        XCTAssertNotNil(sut.dataProvider.taskManager)
        //В языке Swift есть также два оператора проверки на идентичность/тождественность
        // (=== и !==), определяющие, ссылаются ли два указателя на один и тот же экземпляр объекта
        XCTAssertTrue(newTaskViewController.taskManager === sut.dataProvider.taskManager)
    }
    
    func testWhenViewAppearedTableViewReloaded() {
        let mockTableView = MockTableView()
        sut.tableView = mockTableView
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertTrue((sut.tableView as! MockTableView).isReloaded)
    }
    
    func testTappingCellSendsNotification() {
        let task = Task(title: "Foo")
        sut.dataProvider.taskManager?.add(task: task)
        
        expectation(forNotification: NSNotification.Name(rawValue: "DidSelectRow notification"), object: nil) { notification -> Bool in
            guard let taskFromNotification = notification.userInfo?["task"] as? Task else { return false }
            
            return task == taskFromNotification
        }
        let tableView = sut.tableView
        tableView?.delegate?.tableView?(tableView!, didSelectRowAt: IndexPath(row: 0, section: 0))
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSelectedCellNotificationPushesDetailCiewController() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        UIApplication.shared.keyWindow?.rootViewController = sut
        
        sut.loadViewIfNeeded()
        
        let taskOne = Task(title: "Foo")
        let taskTwo = Task(title: "Baz")
        sut.dataProvider.taskManager?.add(task: taskOne)
        sut.dataProvider.taskManager?.add(task: taskTwo)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DidSelectRow notification"), object: self, userInfo: ["task" : taskTwo])
        
        guard let detailViewController = mockNavigationController.pushedViewController as? DetailViewController else {
            XCTFail()
            return
        }
        
        detailViewController.loadViewIfNeeded()
        XCTAssertNotNil(detailViewController.titleLabel)
        
        XCTAssertTrue(detailViewController.task == taskTwo)
    }
}

extension TaskListViewControllerTests {
    
    class MockTableView: UITableView {
        
        var isReloaded = false
        
        override func reloadData() {
            isReloaded = true
        }
    }
}

extension TaskListViewControllerTests {
    
    class MockNavigationController: UINavigationController {
        
        var pushedViewController: UIViewController?
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewController = viewController
            super.pushViewController(viewController, animated: animated)
        }
    }
}
