import XCTest
@testable import Lesson25

class APIClientTests: XCTestCase {

    var mockURLSession: MockURLSession!
    var sut: APIClient!
    
    override func setUpWithError() throws {
        super.setUp()
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
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
    
    // token -> data -> completionHandler -> DataTask -> urlSession
    func testSuccessfulLoginCreatesToken() {
        let jsonDataStub = "{\"token\":\"tokenString\"}".data(using: .utf8)
        mockURLSession = MockURLSession(data: jsonDataStub, urlResponse: nil, responseError: nil)
        sut.urlSession = mockURLSession
        
        let tokerExpectation = expectation(description: "Token expectation")
        
        var caughtToken: String?
        sut.login(withName: "Login", password: "Password") { token, _ in
            caughtToken = token
            tokerExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(caughtToken, "tokenString")
        }
    }
}

extension APIClientTests {
    
    class MockURLSession: URLSessionProtocol {
        
        var url: URL?
        private let mockDataTask: MockURLSessionDataTask
        
        var urlComponent: URLComponents? {
            guard let url = url else { return nil }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            mockDataTask = MockURLSessionDataTask(data: data, urlResponse: urlResponse, responseError: responseError)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            
//            return URLSession.shared.dataTask(with: url)
            
            mockDataTask.completionHandler = completionHandler
            return mockDataTask
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = responseError
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(
                    self.data,
                    self.urlResponse,
                    self.responseError)
            }
        }
    }
}
