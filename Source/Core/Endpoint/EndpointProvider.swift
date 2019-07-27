//
//  EndpointProvider.swift
//  Fetcher
//
//  Created by Filip Dolnik on 04.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

public protocol EndpointProvider {
    
    var implicitModifiers: [RequestModifier] { get }
}

extension EndpointProvider {
 
    public var implicitModifiers: [RequestModifier] {
        return []
    }
}

extension EndpointProvider {
    
    public func create<IN, OUT, T: Endpoint<IN, OUT>>(_ path: String, modifiers: [RequestModifier],
                       inType: IN.Type = IN.self, outType: OUT.Type = OUT.self) -> T {
        return T(path, modifiers: [modifiers, implicitModifiers].flatMap { $0 })
    }
    
    public func create<IN, OUT, T: Endpoint<IN, OUT>>(_ path: String, inputEncoding: InputEncoding, modifiers: [RequestModifier],
                       inType: IN.Type = IN.self, outType: OUT.Type = OUT.self) -> T {
        return T(path, inputEncoding: inputEncoding, modifiers: [modifiers, implicitModifiers].flatMap { $0 })
    }
    
    public func create<IN, OUT, T: Endpoint<IN, OUT>>(_ path: String,
                       inType: IN.Type = IN.self, outType: OUT.Type = OUT.self,
                       modifiers: RequestModifier...) -> T {
        return create(path, modifiers: modifiers)
    }
    
    public func create<IN, OUT, T: Endpoint<IN, OUT>>(_ path: String, inputEncoding: InputEncoding,
                       inType: IN.Type = IN.self, outType: OUT.Type = OUT.self,
                       modifiers: RequestModifier...) -> T {
        return create(path, inputEncoding: inputEncoding, modifiers: modifiers)
    }
}
