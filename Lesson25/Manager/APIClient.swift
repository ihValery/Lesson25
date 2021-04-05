import Foundation

protocol URLSessionProtocol {
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class APIClient {
        
    //Когда работаем с сессией - это 99% URLSession.shared - дефолтная
    //Так как довольно тяжелый экземпляр, то создовать будем исключительно когда он нужен
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    
    func login(withName name: String, password: String, complitionHandler: @escaping (String?, Error?) -> Void) {
        
        //URLQueryAllowed "#%<>[\]^`{|}
        let allowedCharecters = CharacterSet.urlQueryAllowed
        
        guard let name = name.addingPercentEncoding(withAllowedCharacters: allowedCharecters),
              let password = password.addingPercentEncoding(withAllowedCharacters: allowedCharecters)
              else { fatalError() }
        
        let query = "name=\(name)&password=\(password)"
        
        guard let url = URL(string: "https://Lesson25.com/login?\(query)") else { fatalError() }
        urlSession.dataTask(with: url) { (data, response, error) in
            
        }.resume()
    }
}
