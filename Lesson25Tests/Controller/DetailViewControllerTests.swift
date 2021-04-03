import XCTest
import CoreLocation
@testable import Lesson25

class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController!
    
    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testHasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionLabel() {
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
    }
    
    func testHasDateLabel() {
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
    }
    
    func testHasMapView() {
        XCTAssertNotNil(sut.mapView)
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }
    
    func testHasLocationLabel() {
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
    }
    
    func setupTaskWithAllData() {
        let coordinate = CLLocationCoordinate2D(latitude: 40.29641744, longitude: 17.75364876)
        let location = Location(name: "Baz", coordinate: coordinate)
        let date = Date(timeIntervalSince1970: 1617397200)
        let task = Task(title: "Foo", description: "Bar", location: location, date: date)
        
        sut.task = task
        //Дергаем viewWillAppear(_:) viewDidAppear(_:)
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
    }
    
    func testSettigTaskSetsTitleLabel() {
        setupTaskWithAllData()
        XCTAssertEqual(sut.titleLabel.text, "Foo")
    }
    
    func testSettigTaskSetsDescriptionLabel() {
        setupTaskWithAllData()
        XCTAssertEqual(sut.descriptionLabel.text, "Bar")
    }
    
    func testSettigTaskSetsLocationLabel() {
        setupTaskWithAllData()
        XCTAssertEqual(sut.locationLabel.text, "Baz")
    }
    
    func testSettigTaskSetsDateLabel() {
        setupTaskWithAllData()
        XCTAssertEqual(sut.dateLabel.text, "03.04.21")
    }
    
    func testSettigTaskSetsMapView() {
        setupTaskWithAllData()
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, 40.29641744, accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, 17.75364876, accuracy: 0.001)
    }
}
