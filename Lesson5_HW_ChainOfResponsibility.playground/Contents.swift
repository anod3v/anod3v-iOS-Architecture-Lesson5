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
    
    func requestData<T: Codable>(from data: Data, of type: T.Type, completion: @escaping (T?, Error?) -> Void) {
        let decoder = JSONDecoder()
        
        do {
            
            let result: T = try decoder.decode(T.self, from: data)
            debugPrint("result:", result)
            completion(result, nil)
            
        } catch (let error) {
            
            completion(nil, error)
        }
    }
         
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
        return jsonParser.requestData(from: data, of: [Person].self) { (result, error) in
            if let result = result {
            print(result)
            }
            else {
                self.next?.parseData(data)
            }
            print(result)
        }
}
}

class Data2Parser: DataParser {
    
    var next: DataParser?
    
    func parseData(_ data: Data) {
        return jsonParser.requestData(from: data, of: Response.self) { (result, error) in
            if let result = result {
            print(result)
            }
            else {
                self.next?.parseData(data)
            }
        }
    }
}

class Data3Parser: DataParser {
    
    var next: DataParser?
    
        func parseData(_ data: Data) {
        return jsonParser.requestData(from: data, of: Response.self) { (result, error) in
            if let result = result {
            print(result)
            }
            else {
                self.next?.parseData(data)
            }
        }
}
}

let data1Parser = Data1Parser()
let data2Parser = Data2Parser()
let data3Parser = Data3Parser()
let errorHandler: DataParser = data1Parser

data1Parser.next = data2Parser
data2Parser.next = data3Parser
data3Parser.next = nil


    func startParsingData(_ data: Data) {
        return jsonParser.requestData(from: data, of: Response.self) { (result, error) in
            if let result = result {
            print(result)
            }
            else {
                data1Parser.parseData(data)
            }
        }
    }

startParsingData(data1)




