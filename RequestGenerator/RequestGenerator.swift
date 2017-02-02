// ../Source/Core/Fetcher+Request.swift
//
//  RequestGenerator.swift
//  Fetcher
//
//  Created by Filip Dolnik on 08.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

print("// This file is generated by RequestGenerator script.")
print("")
print("import DataMapper")
for output in outputTypes {
    print("")
    print("// Extension for output type \(output).")
    print("extension Fetcher {")
    for input in inputTypes {
        let inputSigniture = input.isVoid ? "" : ", input: \(input)"
        let inputProvider: String
        let outputProvider: String
        let genericSigniture: String
        
        if input.isKnownType && output.isKnownType {
            genericSigniture = ""
        } else if input.isKnownType {
            genericSigniture = "<OUT: Deserializable>"
        } else if output.isKnownType {
            genericSigniture = "<IN: Serializable>"
        } else {
            genericSigniture = "<IN: Serializable, OUT: Deserializable>"
        }
        
        if input.isSupportedType || input.isData {
            inputProvider = "input"
        } else if input.isVoid {
            inputProvider = ".null"
        } else {
            inputProvider = "self.objectMapper.serialize(input)"
        }
        
        if output.isSupportedType || output.isData {
            outputProvider = "$0"
        } else if output.isVoid {
            outputProvider = "_ in Void()"
        } else  {
            outputProvider = "self.objectMapper.deserialize($0)"
        }
        
        print("")
        print("    @discardableResult")
        print("    public func request\(genericSigniture)(_ endpoint: Endpoint<\(input), \(output)>\(inputSigniture), callback: @escaping (Response<\(output)>) -> Void) -> Cancellable {")
        print("        return run(endpoint: endpoint, inputProvider: { \(inputProvider) }, outputProvider: { \(outputProvider) }, callback: callback)")
        print("    }")
    }
    print("}")
}
