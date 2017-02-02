//
//  RequestLogger.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 27/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import DataMapper

public final class RequestLogger: RequestEnhancer {
    
    private let defaultOptions: RequestLogging
    private let logFunction: (String) -> Void
    
    public init(defaultOptions: RequestLogging = [.requestUrl, .responseCode, .time], logFunction: @escaping (String) -> Void = { print($0) }) {
        self.defaultOptions = defaultOptions
        self.logFunction = logFunction
    }
    
    public func enhance(request: inout Request) {
        request.modifiers.append(RequestLoggerTimestamp(time: Date()))
    }
    
    public func deenhance(response: inout Response<SupportedType>) {
        let log = createLog(for: response)
        if !log.isEmpty {
            logFunction(log)
        }
    }
    
    private func createLog(for response: Response<SupportedType>) -> String {
        var result = ""
        let modifiers = response.request.modifiers.flatMap { $0 as? RequestLogging }
        let options = modifiers.count == 0 ? defaultOptions : modifiers.reduce(RequestLogging.disabled) { acc, element in acc.union(element) }
        
        guard options != .disabled else { return "" }
        
        result += "----- Begin of request log -----\n"
        
        if options.contains(.requestUrl) {
            let url = response.request.url?.absoluteString ?? "<< unknown URL >>"
            result += "\nRequest url: \(response.request.httpMethod.rawValue) \(url)\n"
        }
        
        if options.contains(.time) {
            result += "\nTime: "
            if let timestamp = response.request.modifiers.flatMap({ $0 as? RequestLoggerTimestamp }).first {
                result += String(format: "%.2fs", arguments: [-timestamp.time.timeIntervalSinceNow]) + "\n"
            } else {
                result += "unknown\n"
            }
        }
        
        if options.contains(.responseCode) {
            result += "\nResponse status code: "
            if let statusCode = response.rawResponse?.statusCode {
                result += "\(statusCode)\n"
            } else {
                result += "unknown\n"
            }
        }
        
        if options.contains(.requestHeaders) {
            result += "\nRequest headers: "
            if let headers = response.request.allHTTPHeaderFields, !headers.isEmpty {
                result += "\n"
                headers.forEach { name, value in
                    result += "\t\(name): \(value)\n"
                }
            } else {
                result += "empty\n"
            }
        }
        
        if options.contains(.requestBody) {
            result += "\nRequest body: "
            if let requestBody = response.request.httpBody {
                if let requestBodyText = String(data: requestBody, encoding: .utf8) {
                    result += "\(requestBodyText)\n"
                } else {
                    result += "unknown format\n"
                }
                result += "\(requestBody)\n"
            } else {
                result += "empty\n"
            }
        }
        
        if options.contains(.responseHeaders) {
            result += "\nResponse headers: "
            if let headers = response.rawResponse?.allHeaderFields, !headers.isEmpty {
                result += "\n"
                headers.forEach { name, value in
                    result += "\t\(name): \(value)\n"
                }
            } else {
                result += "empty\n"
            }
        }
        
        if options.contains(.responseBody) {
            result += "\nResponse body: "
            if let responseBody = response.rawString {
                result += "\(responseBody)\n"
            } else {
                result += "empty\n"
            }
        }
        
        result += "\n----- End of request log -----\n"
        return result
    }
}
