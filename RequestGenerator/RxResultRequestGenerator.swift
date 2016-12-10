// ../RxRouter/RxRouter+ResultRequest.swift
//
//  RxResultRequestGenerator.swift
//  SwiftKit
//
//  Created by Filip Dolnik on 10.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

print("// This file is generated by RxResultRequestGenerator script.")
print("")
print("import RxSwift")
print("import DataMapper")
for output in outputTypes {
    print("")
    print("// Extension for output type \(output).")
    print("extension RxRouter {")
    for input in inputTypes {
        let inputSigniture = input.isVoid ? "" : ", input: \(input)"
        let inputProvider = input.isVoid ? "" : ", input: input"
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
        
        print("")
        print("    public func request\(genericSigniture)(_ endpoint: Endpoint<\(input), \(output)>\(inputSigniture)) -> Observable<RouterResult<\(output)>> {")
        print("        return observe { callback in router.request(endpoint\(inputProvider), callback: callback) }")
        print("    }")
    }
    print("}")
}
