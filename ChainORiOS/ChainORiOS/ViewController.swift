//
//  ViewController.swift
//  ChainORiOS
//
//  Created by Andrey on 08/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let data1Parser = Data1Parser()
    let data2Parser = Data2Parser()
    let data3Parser = Data3Parser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data1Parser.next = data2Parser
        data2Parser.next = data3Parser
        data3Parser.next = nil
        
        data1Parser.parseData(data3)
        
    }
    
    func data(from file: String) -> Data {
        let path1 = Bundle.main.path(forResource: file, ofType: "json")!
        let url = URL(fileURLWithPath: path1)
        let data = try! Data(contentsOf: url)
        return data
    }
    
    lazy var data1 = data(from: "1")
    lazy var data2 = data(from: "2")
    lazy var data3 = data(from: "3")
    
    struct Person: Codable {
        let age: Int
        let isDeveloper: Bool
        let name: String
        
        
        enum CodingKeys: String, CodingKey {
            case age
            case isDeveloper
            case name
            
        }
    }
    
    struct Response1: Codable {
        let data: [Person]
        private enum CodingKeys: String, CodingKey {
            case data = "data"
        }
    }
    
    struct Response2: Codable {
        let data: [Person]
        private enum CodingKeys: String, CodingKey {
            case data = "result"
        }
    }
    
    
    class Data1Parser: DataParser {
        
        var next: DataParser?
        
        func parseData(_ data: Data) {
            return JSONParserFromStruct.requestData(from: data, of: Response1.self) { (result, error) in
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
            return JSONParserFromStruct.requestData(from: data, of: Response2.self) { (result, error) in
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
            return JSONParserFromStruct.requestData(from: data, of: [Person].self) { (result, error) in
                if let result = result {
                    print(result)
                }
                else {
                    self.next?.parseData(data)
                }
            }
        }
    }
    
}

protocol DataParser {
    
    var next: DataParser? { get set }
    
    func parseData(_ data: Data)
}





