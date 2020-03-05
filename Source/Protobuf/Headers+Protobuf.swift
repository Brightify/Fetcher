//
//  Headers.ContentType+Protobuf.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 04/03/2020.
//  Copyright © 2020 Brightify. All rights reserved.
//

import Foundation

extension Headers.ContentType {
    public static let protocolBuffers = Headers.ContentType(value: "application/x-protobuf")
}

extension Headers.Accept {
    public static let protocolBuffers = Headers.ContentType(value: "application/x-protobuf")
}
