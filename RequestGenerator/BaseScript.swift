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
let inputData = [".string(\"a\")", "\"\"", "\"a\".data(using: .utf8)!", "1", "nil", "[1, 2]", "nil",
                 "[1, nil]", "nil", "[\"a\": 1]", "nil", "[\"a\": nil]", "nil"]
let jsonInputData = ["\"\\\"a\\\"\"", "\"\"", "\"a\"", "\"1\"", "\"\"", "\"[1,2]\"", "\"\"",
                     "\"[1,null]\"", "\"\"", "\"{\\\"a\\\":1}\"", "\"\"", "\"{\\\"a\\\":null}\"", "\"\""]

let outputTypes = ["SupportedType", "Void", "Data", "OUT", "[OUT]", "[OUT?]", "[String: OUT]", "[String: OUT?]"]
let outputData = [".string(\"a\")", "\"\"", "\"a\"", "1", "[1, 2]", "[Optional(1), nil]", "[\"a\": 1]", "[\"a\": nil]"]
let jsonOutputData = ["\"\\\"a\\\"\"", "\"\"", "\"a\"", "\"1\"", "\"[1,2]\"", "\"[1,null]\"", "\"{\\\"a\\\":1}\"", "\"{\\\"a\\\":null}\""]
