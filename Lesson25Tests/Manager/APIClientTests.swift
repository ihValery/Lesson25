import XCTest
@testable import Lesson25

class APIClientTests: XCTestCase {

    var mockURLSession: MockURLSession!
    var sut: APIClient!
    
    override func setUpWithError() throws {
        super.setUp()
        mockURLSession = MockURLSession()
        sut = APIClient()
        sut.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
        
        super.tearDown()
    }
    
    func setUserLogin() {
        let complitionHandler = {(token: String?, error: Error?) in }
        sut.login(withName: "Valery", password: "%104", complitionHandler: complitionHandler)
    }

    func testLoginUsesCorrectHost() {
        setUserLogin()
        XCTAssertEqual(mockURLSession.urlComponent?.host, "Lesson25.com")
    }
    
    func testLoginUsesCorrectPath() {
        setUserLogin()
        XCTAssertEqual(mockURLSession.urlComponent?.path, "/login")
    }
    
    //Вход использует ожидаемый запрос - параметры
    //query - (?) идут параметры q=Hello&safe=off. Они состоят из пар ключ-значение.
    //Зафейлится если последовательность будет нарушена, разобъем на два
    func testLoginUsesExpectedQuery() {
        setUserLogin()
        XCTAssertEqual(mockURLSession.urlComponent?.percentEncodedQuery, "name=Valery&password=%25104")
    }
    
    func testLoginUsesExpectedQueryItemsParametrs() {
        setUserLogin()
        guard let queryItems = mockURLSession.urlComponent?.queryItems else {
            XCTFail()
            return
        }
        let urlQueryItemName = URLQueryItem(name: "name", value: "Valery")
        let urlQueryItemPassword = URLQueryItem(name: "password", value: "%104")
        
        XCTAssertTrue(queryItems.contains(urlQueryItemName))
        XCTAssertTrue(queryItems.contains(urlQueryItemPassword))
    }
}

extension APIClientTests {
    
    class MockURLSession: URLSessionProtocol {
        
        var url: URL?
        var urlComponent: URLComponents? {
            guard let url = url else { return nil }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            
            return URLSession.shared.dataTask(with: url)
        }
    }
}
