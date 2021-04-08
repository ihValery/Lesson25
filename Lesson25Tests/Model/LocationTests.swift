import XCTest
import CoreLocation
@testable import Lesson25

class LocationTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testInitSetName() {
        let location = Location(name: "Foo")
        XCTAssertTrue(location.name == "Foo")
    }
    
    func testInitSetCoordinatesLatitude() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "Foo", coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
    }
    
    func testInitSetCoordinatesLongitude() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "Foo", coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    func testCanBeCreatedFromPlistDictionary() {
        let location = Location(name: "Foo", coordinate: CLLocationCoordinate2DMake(10.0, 10.0))

        let dictionary: [String : Any] = ["name" : "Foo",
                                           "latitude" : 10.0,
                                           "longitude" : 10.0]
        
        let createdLocation = Location(dict: dictionary)
        
        XCTAssertEqual(location, createdLocation)
    }
    
    func testCanBeSerializedIntodictionary() {
        let location = Location(name: "Foo", coordinate: CLLocationCoordinate2DMake(10.0, 10.0))
        
        let generatedLocation = Location(dict: location.dict)
        
        XCTAssertEqual(location, generatedLocation)
    }
}
