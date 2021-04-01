import XCTest
import CoreLocation
@testable import Lesson25

class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitSetName()
    {
        let location = Location(name: "Foo")
        XCTAssertTrue(location.name == "Foo")
    }
    
    func testInitSetCoordinatesLatitude()
    {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "Foo", coordinate: coordinate)
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
    }
    
    func testInitSetCoordinatesLongitude()
    {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "Foo", coordinate: coordinate)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
}
