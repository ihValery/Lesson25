import XCTest
@testable import Lesson25

class TaskTests: XCTestCase {
    
    //Создание задачи при инициализации с заголовком
    func testInitTaskWithTitle() {
        let task = Task(title: "Foo")
        XCTAssertNotNil(task, "Задача не создалась")
    }
    
    func testInitTaskWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertNotNil(task)
    }
    
    func testWhenGivenTitleSetsTitle() {
        let task = Task(title: "Foo")
        XCTAssertEqual(task.title, "Foo", "Задача не создалась")
    }
    
    func testWhenGivenDescriptionSetsDescription() {
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertTrue(task.description == "Bar", "Описание не создалось")
    }
    
    func testTaskInitWithDate() {
        let task = Task(title: "Foo")
        XCTAssertNotNil(task.date, "У задачи нет даты")
    }
    
    func testWhenGivenLocationSetsLocation() {
        let location = Location(name: "Foo")
        let task = Task(title: "Bar", description: "Baz", location: location)
        
        XCTAssertEqual(location, task.location)
    }
}
