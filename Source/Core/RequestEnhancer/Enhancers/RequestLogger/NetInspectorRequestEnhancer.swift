//
//  NetInspectorRequestEnhancer.swift
//  Fetcher
//
//  Created by Robin Krenecky on 14/09/2018.
//  Copyright © 2018 Brightify. All rights reserved.
//

import DataMapper
import Alamofire

private extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}
private extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}

public final class NetInspectorRequestEnhancer: RequestEnhancer {
    private let netInspectorBaseURL: String
    private let port = 1111

    private let applicationId: String
    private let headers: [String: String]
    private let uuid: String

    public init(netInspectorBaseURL: String) {
        self.netInspectorBaseURL = netInspectorBaseURL
        self.applicationId = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        self.headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        self.uuid = UUID().uuidString
        register()
    }

    public var instancePriority: RequestEnhancerPriority? {
        return .low
    }

    public func deenhance(response: inout Response<SupportedType>) {
        let duration = -Int((response.request.modifiers.compactMap({ $0 as? RequestLoggerTimestamp }).first?.time.timeIntervalSinceNow ?? 0) * 1000)
        var requestBody = ""
        if let data = response.request.httpBody {
            requestBody = String(data: data, encoding: .utf8) ?? ""
        }

        var headersResult = "\nResponse headers: "
        if let headers = response.rawResponse?.allHeaderFields, !headers.isEmpty {
            headersResult += "\n"
            headers.forEach { name, value in
                headersResult += "\t\(name): \(value)\n"
            }
        } else {
            headersResult += "empty\n"
        }

        let parameters = [
            "uuid": UUID().uuidString,
            "url": response.request.url?.absoluteString ?? "<< unknown URL >>",
            "method": response.request.httpMethod.rawValue,
            "responseCode": "\(response.rawResponse?.statusCode ?? 0)",
            "startTime": Date().iso8601,
            "duration": "\(duration)",
            "headers": headersResult,
            "requestBody": requestBody,
            "responseBody": response.rawString ?? ""
        ]

        Alamofire.request(URL(string: "\(netInspectorBaseURL):\(port)/\(uuid)/logItem/")!, method: .post, parameters: parameters, headers: headers).response { _ in
        }
    }

    private func register() {
        let parameters = [
            "uuid": uuid,
            "applicationName": Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String,
            "applicationBundleIdentifier": Bundle.main.bundleIdentifier!,
            "applicationVersion": Bundle.main.infoDictionary![kCFBundleVersionKey as String] as! String
        ]

        Alamofire.request(URL(string: "\(netInspectorBaseURL):\(port)/registration")!, method: .post, parameters: parameters, headers: headers).response { _ in
        }
    }
}
