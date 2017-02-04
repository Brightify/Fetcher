//
//  BaseScript.swift
//  Fetcher
//
//  Created by Filip Dolnik on 10.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

// yes y | FetcherRequestGenerator/run

import Foundation

extension String {
    
    var isVoid: Bool {
        return self == "Void"
    }
    
    var isSupportedType: Bool {
        return self == "SupportedType"
    }
    
    var isData: Bool {
        return self == "Data"
    }
    
    var isKnownType: Bool {
        return isVoid || isSupportedType || isData
    }
}

let inputTypes = ["SupportedType", "Void", "Data", "IN", "IN?", "[IN]", "[IN]?",
                  "[IN?]", "[IN?]?", "[String: IN]", "[String: IN]?", "[String: IN?]", "[String: IN?]?"]
let outputTypes = inputTypes.map { $0.replacingOccurrences(of: "IN", with: "OUT") }

let data = [".string(\"a\")", "\"\"", "\"a\"", "1", "nil", "[1, 2]", "nil",
            "[Optional(1), nil]", "nil", "[\"a\": 1]", "nil", "[\"a\": nil]", "nil"]
let jsonData = ["\"\\\"a\\\"\"", "\"\"", "\"a\"", "\"1\"", "\"\"", "\"[1,2]\"", "\"\"",
                "\"[1,null]\"", "\"\"", "\"{\\\"a\\\":1}\"", "\"\"", "\"{\\\"a\\\":null}\"", "\"\""]
