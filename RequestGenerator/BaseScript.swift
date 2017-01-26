//
//  BaseScript.swift
//  Fetcher
//
//  Created by Filip Dolnik on 10.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

// yes y | FetcherRequestGenerator/run

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

let inputTypes = ["SupportedType", "Void", "Data", "IN", "IN?", "[IN]", "[IN]?", "[IN?]", "[IN?]?", "[String: IN]", "[String: IN]?", "[String: IN?]", "[String: IN?]?"]
let outputTypes = ["SupportedType", "Void", "Data", "OUT", "[OUT]", "[OUT?]", "[String: OUT]", "[String: OUT?]"]
