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

class JSONParserFromStruct {
    
    func requestData<Output: Codable>(data: Data, completion: @escaping (Output?, Error?) -> Void) {
        let decoder = JSONDecoder()
        let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        debugPrint("jsonData:", jsonData)
        
        do {
            
            let result = try decoder.decode(Output.self, from: data)
            debugPrint("result:", result)
            completion(result, nil)
         
}

let jsonParser = JSONParserFromStruct()

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

struct Response: Codable {
    let data: [Person]
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}



protocol DataParser {
    
    var next: DataParser? { get set }
    
    func parseData(_ data: Data)
}

class Data1Parser: DataParser {
    
    var next: DataParser?
    
    func parseData(_ data: Data) {
        return jsonParser.downloadList(of: [Person].self, from: data) { (result, error) in
        }
}

class Data2Parser: DataParser {
    
    var next: DataParser?
    
    func parseData(_ data: Data) {
        guard let data2Error = error as? Data2Error else {
            self.next?.parseData(error)
            return
        }
        print(data2Error)
        // show alert
        // try repeat network request
    }
}

class Data3Parser: DataParser {
    
    var next: DataParser?
    
    func parseData(_ data: Data) {
        guard let data3Error = error as? Data3Error else {
            self.next?.parseData(error)
            return
        }
        print(data3Error)
        // show error view controller
        // try repeat request
        // log error
    }
}

let data1Parser = Data1Parser()
let data2Parser = Data2Parser()
let data3Parser = Data3Parser()
let errorHandler: DataParser = data1Parser

data1Parser.next = data2Parser
data2Parser.next = data3Parser
data3Parser.next = nil

requestData(data: data1) { (person, error) in
    if let error = error {
        errorHandler.handleError(error)
    }
    if let person = person {
        debugPrint(person)
    }
}

}
