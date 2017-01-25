//
//  AlamofireJsonDataEncoder.swift
//  SwiftKit
//
//  Created by Filip Dolnik on 10.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import Alamofire
import DataMapper

public struct AlamofireJsonDataEncoder: DataEncoder {
    
    private let serializer = JsonSerializer()
    
    public init() {
    }
    
    public func encodeToQueryString(input: SupportedType, to request: inout Request) {
        encode(using: .queryString, input: input, to: &request)
    }
    
    public func encodeToHttpBody(input: SupportedType, to request: inout Request) {
        request.httpBody = serializer.serialize(input)
        request.modifiers.append(Headers.ContentType.applicationJson)
        request.modifiers.append(Headers.Charset.utf8)
    }
    
    public func encodeCustom(input: SupportedType, to request: inout Request, inputEncoding: InputEncoding) {
        if inputEncoding is FormInputEncoding {
            encode(using: .httpBody, input: input, to: &request)
            request.modifiers.append(Headers.ContentType.applicationFormUrlencoded)
            request.modifiers.append(Headers.Charset.utf8)
        } else {
            fatalError("Unknown input encoding \(inputEncoding).")
        }
    }
    
    public func decode(response: Response<Data>) -> Response<SupportedType> {
        return response.map(serializer.deserialize)
    }
    
    private func encode(using urlEncoding: URLEncoding, input: SupportedType, to request: inout Request) {
        guard let dictionary = input.dictionary else {
            assertionFailure("Input data has to be in format [String: Any].")
            return
        }
        
        let data = dictionary.mapValue { serializer.typedSerialize($0) }
        
        // Iqnore error from Alamofire because it is handled elsewhere (program already crashed if there is a problem).
        request.urlRequest = (try? urlEncoding.encode(request.urlRequest, with: data)) ?? request.urlRequest
    }
}
