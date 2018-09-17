//
//  NetInspectorRequestEnhancer.swift
//  Fetcher
//
//  Created by Robin Krenecky on 14/09/2018.
//  Copyright © 2018 Brightify. All rights reserved.
//

import DataMapper
import Alamofire

struct Registration: Encodable {
    var uuid: UUID
    var applicationName: String
    var applicationBundleIdentifier: String
    var applicationVersion: String
}

struct LogItem: Codable {
    let uuid: UUID
    let request: Request
    let response: Response?
}

extension LogItem {
    var duration: TimeInterval? {
        guard let end = response?.time else { return nil }
        return end.timeIntervalSince(request.time)
    }
}

extension LogItem {
    struct Request: Codable {
        let method: String /* FIXME Should be HTTPMethod */
        let url: URL
        let headers: [String: String]
        let time: Date
        let body: String
    }

    struct Response: Codable {
        let headers: [String: String]
        let time: Date
        let body: String
        let code: Int
    }
}

internal struct NetInspectorTimestamp: RequestModifier {
    internal let time: Date
    internal let uuid: UUID
}

public final class NetInspectorRequestEnhancer: RequestEnhancer {
    private let netInspectorBaseURL: URL
    private let port = 1111
    private let applicationId: String
    private let uuid: UUID

    public init(netInspectorBaseURL: String) {
        var components = URLComponents(string: netInspectorBaseURL)!
        components.port = 1111
        self.netInspectorBaseURL = components.url!
        self.applicationId = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        self.uuid = UUID()
        try! register()
    }

    public var instancePriority: RequestEnhancerPriority? {
        return .low
    }

    public func enhance(request: inout Request) {
        request.modifiers.append(NetInspectorTimestamp(time: Date(), uuid: UUID()))
    }

    public func deenhance(response: inout Response<SupportedType>) {
        guard let timestamp = response.request.modifiers.compactMap({ $0 as? NetInspectorTimestamp }).first else { return }

        let requestBody = response.request.httpBody.flatMap { String(data: $0, encoding: .utf8) } ?? ""

        let allRequestHeaders = response.request.allHTTPHeaderFields?.compactMap { key, value -> (key: String, value: String)? in
            guard let keyString = key as? String, let valueString = value as? String else { return nil }
            return (key: keyString, value: valueString)
            } ?? []
        let requestHeaders = Dictionary(allRequestHeaders, uniquingKeysWith: { $1 })

        let allResponseHeaders = response.rawResponse?.allHeaderFields.compactMap { key, value -> (key: String, value: String)? in
            guard let keyString = key as? String, let valueString = value as? String else { return nil }
            return (key: keyString, value: valueString)
            } ?? []
        let responseHeaders = Dictionary(allResponseHeaders, uniquingKeysWith: { $1 })

        let logItem = LogItem(
            uuid: UUID(),
            request: LogItem.Request(
                method: response.request.httpMethod.rawValue,
                url: response.request.url ?? netInspectorBaseURL,
                headers: requestHeaders,
                time: timestamp.time,
                body: requestBody),
            response: LogItem.Response(
                headers: responseHeaders,
                time: Date(),
                body: response.rawString ?? "",
                code: response.rawResponse?.statusCode ?? 0))

        try? post(to: "api/runs/\(uuid.uuidString)/logItems", value: logItem)
    }

    private func register() throws {
        let registration = Registration(
            uuid: uuid,
            applicationName:  Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String,
            applicationBundleIdentifier: Bundle.main.bundleIdentifier!,
            applicationVersion: Bundle.main.infoDictionary![kCFBundleVersionKey as String] as! String)

        try post(to: "api/runs", value: registration)
    }

    private func post<T: Encodable>(to endpoint: String, value: T) throws {
        let url = netInspectorBaseURL.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(value)

        URLSession.shared.dataTask(with: request) { data, response, error in
            // TODO Handle the response
            }.resume()
    }
}
