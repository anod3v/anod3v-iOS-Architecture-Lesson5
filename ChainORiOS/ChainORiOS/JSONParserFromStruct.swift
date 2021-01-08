//
//  JSONParserFromStruct.swift
//  ChainORiOS
//
//  Created by Andrey on 08/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import Foundation

class JSONParserFromStruct {
    
    static func requestData<T: Codable>(from data: Data, of type: T.Type, completion: @escaping (T?, Error?) -> Void) {
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
