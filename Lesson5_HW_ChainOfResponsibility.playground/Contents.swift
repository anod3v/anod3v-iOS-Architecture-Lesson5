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

enum Data1Error: Error {
    case loginDoesNotExist
    case wrongPassword
    case smsCodeInvalid
}

enum Data2Error: Error {
    case noConnection
    case serverNotResponding
}

enum Data3Error: Error {
    case sessionInvalid
    case versionIsNotSupported
    case general
}

func requestData<Output: Codable>(data: Data, completion: @escaping (Output?, Error?) -> Void) {
    let decoder = JSONDecoder()
    let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
    debugPrint("jsonData:", jsonData)
    
    do {
        
        let result = try decoder.decode(Output.self, from: data)
        debugPrint("result:", result)
        completion(result, nil)
        
    } catch (let error) {
        
        completion(nil, error)
    }
}

struct Person: Codable {
    let age: Int
    let isDeveloper: Int
    let name: String


    enum CodingKeys: String, CodingKey {
        case age
        case isDeveloper
        case name

    }
}

struct Data1Response<T: Codable>: Codable {
    let data: [Person]
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}



protocol ErrorHandler {
    
    var next: ErrorHandler? { get set }
    
    func handleError(_ error: Error)
}

class Data1ErrorHandler: ErrorHandler {
    
    var next: ErrorHandler?
    
    func handleError(_ error: Error) {
        guard let data1Error = error as? Data1Error else {
            self.next?.handleError(error)
            return
        }
        print(data1Error)
        // show tooltip
    }
}

class Data2ErrorHandler: ErrorHandler {
    
    var next: ErrorHandler?
    
    func handleError(_ error: Error) {
        guard let data2Error = error as? Data2Error else {
            self.next?.handleError(error)
            return
        }
        print(data2Error)
        // show alert
        // try repeat network request
    }
}

class Data3ErrorHandler: ErrorHandler {
    
    var next: ErrorHandler?
    
    func handleError(_ error: Error) {
        guard let data3Error = error as? Data3Error else {
            self.next?.handleError(error)
            return
        }
        print(data3Error)
        // show error view controller
        // try repeat request
        // log error
    }
}

let data1ErrorHandler = Data1ErrorHandler()
let data2ErrorHandler = Data2ErrorHandler()
let data3ErrorHandler = Data3ErrorHandler()
let errorHandler: ErrorHandler = data1ErrorHandler

data1ErrorHandler.next = data2ErrorHandler
data2ErrorHandler.next = data3ErrorHandler
data3ErrorHandler.next = nil

requestData(data: data1) { (person, error) in
    if let error = error {
        errorHandler.handleError(error)
    }
    if let person = person {
        debugPrint(person)
    }
}

