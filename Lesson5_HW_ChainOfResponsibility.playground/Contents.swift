import UIKit

func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    return data
}

let data1 = data(from: "1")
let data2 = data(from: "2")
let data3 = data(from: "3")

enum LoginError: Error {
    case loginDoesNotExist
    case wrongPassword
    case smsCodeInvalid
}

enum NetworkError: Error {
    case noConnection
    case serverNotResponding
}

enum GeneralError: Error {
    case sessionInvalid
    case versionIsNotSupported
    case general
}

func requestData(data: Data, completion: @escaping (Person?, Error?) -> Void) {
    let decoder = JSONDecoder()
    let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
    debugPrint("jsonData:", jsonData)
    
    do {
        
        let result = try decoder.decode(Person.self, from: data)
        debugPrint("result:", result)
        completion(result, nil)
        
    } catch (let error) {
        
        completion(nil, error)
    }
}

struct Person: Codable {
    let id: Int
    let firstName, lastName: String
    let photo_200: String
    let trackCode: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case photo_200
        case trackCode
    }
}



protocol ErrorHandler {
    
    var next: ErrorHandler? { get set }
    
    func handleError(_ error: Error)
}

class LoginErrorHandler: ErrorHandler {
    
    var next: ErrorHandler?
    
    func handleError(_ error: Error) {
        guard let loginError = error as? LoginError else {
            self.next?.handleError(error)
            return
        }
        print(loginError)
        // show tooltip
    }
}

class NetworkErrorHandler: ErrorHandler {
    
    var next: ErrorHandler?
    
    func handleError(_ error: Error) {
        guard let networkError = error as? NetworkError else {
            self.next?.handleError(error)
            return
        }
        print(networkError)
        // show alert
        // try repeat network request
    }
}

class GeneralErrorHandler: ErrorHandler {
    
    var next: ErrorHandler?
    
    func handleError(_ error: Error) {
        guard let generalError = error as? GeneralError else {
            self.next?.handleError(error)
            return
        }
        print(generalError)
        // show error view controller
        // try repeat request
        // log error
    }
}

let loginErrorHandler = LoginErrorHandler()
let networkErrorHandler = NetworkErrorHandler()
let generalErrorHandler = GeneralErrorHandler()
let errorHandler: ErrorHandler = loginErrorHandler

loginErrorHandler.next = networkErrorHandler
networkErrorHandler.next = generalErrorHandler
generalErrorHandler.next = nil

requestData(data: data1) { (person, error) in
    if let error = error {
        errorHandler.handleError(error)
    }
    if let person = person {
        debugPrint(person)
    }
}

