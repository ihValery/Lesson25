import XCTest
import CoreLocation
@testable import Lesson25

class InputTaskViewControllerTests: XCTestCase {
    
    var sut: InputTaskViewController!
    var placemark: MockCLPlacemark!

    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "InputTaskViewController") as? InputTaskViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        
        super.tearDown()
    }
    
    func testHasTitleTextField() {
        XCTAssertTrue(sut.titleTextField.isDescendant(of: sut.view))
    }
    
    func testHasLocationTextField() {
        XCTAssertNotNil(sut.locationTextField)
    }
    
    func testHasLocationTextFieldInContentView() {
        XCTAssertTrue(sut.locationTextField.isDescendant(of: sut.view))
    }
    
    func testHasDateTextField() {
        XCTAssertNotNil(sut.dateTextField)
    }
    
    func testHasDateTextFieldInContentView() {
        XCTAssertTrue(sut.dateTextField.isDescendant(of: sut.view))
    }
    
    func testHasAddressTextField() {
        XCTAssertNotNil(sut.addressTextField)
    }
    
    func testHasAddressTextFieldInContentView() {
        XCTAssertTrue(sut.addressTextField.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionTextField() {
        XCTAssertNotNil(sut.descriptionTextField)
    }
    
    func testHasDescriptionTextFieldInContentView() {
        XCTAssertTrue(sut.descriptionTextField.isDescendant(of: sut.view))
    }
    
    func testHasSaveButton() {
        XCTAssertNotNil(sut.saveButton)
    }
    
    func testHasSaveButtonInContentView() {
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    
    func testHasCancelButton() {
        XCTAssertNotNil(sut.cancelButton)
    }
    
    func testHasCancelButtonInContentView() {
        XCTAssertTrue(sut.cancelButton.isDescendant(of: sut.view))
    }
    
    func testSaveUsesGeocoderToConvertCoordinateFromAddres() {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = df.date(from: "03.04.21")
        
        sut.titleTextField.text = "Foo"
        sut.locationTextField.text = "Bar"
        sut.dateTextField.text = "03.04.21"
        sut.addressTextField.text = "Минск"
        sut.descriptionTextField.text = "Baz"
        
        sut.taskManager = TaskManager()
        let mockGeocoder = MockCLGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.save()
        
        let coordinate = CLLocationCoordinate2D(latitude: 53.896196, longitude: 27.5503093)
        let location = Location(name: "Bar", coordinate: coordinate)
        let generatedTask = Task(title: "Foo", description: "Baz", location: location, date: date)
        
        placemark = MockCLPlacemark()
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let task = sut.taskManager.task(at: 0)
        
        XCTAssertEqual(task, generatedTask)
    }
    
    func testSaveButtonHasSaveMethod() {
        let saveButton = sut.saveButton
        guard let action = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        XCTAssertTrue(action.contains("save"))
    }
    
    func testGeocoderFetchesCorrectCoordinate() {
        //Ожижание
        let geocoderAnswer = expectation(description: "Geocoder answer")
        let addressString = "Минск"
        let geocoder = CLGeocoder()
    
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            let placemark = placemarks?.first
            let location = placemark?.location
            
            guard let latitude = location?.coordinate.latitude,
                  let longitude = location?.coordinate.longitude else {
                XCTFail()
                return
            }
            XCTAssertEqual(latitude, 53.896196)
            XCTAssertEqual(longitude, 27.5503093)
            //Удовлетвояет ожидание
            geocoderAnswer.fulfill()
        }
        //Тайминг для ожидания - малол ли интернет плохой ))
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}

//Фейковый класс (типо замена инета)
//Вытаскиваем completionHandler для того что бы использовать его в тот момент когда нам это удобно
extension InputTaskViewControllerTests {
    
    class MockCLGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockCLPlacemark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D!
        
        override var location: CLLocation? {
            return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
        }
    }
}
