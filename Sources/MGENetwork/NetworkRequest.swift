//
//  Request.swift
//  NBAPlayers
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

public struct NetworkRequest {
    public let endpoint: Endpoint
    public let method: HTTPMethod
    
    public init(method: HTTPMethod, endpoint: Endpoint) {
        self.method = method
        self.endpoint = endpoint
    }
    
    public func makeURLRequest() throws -> URLRequest {
        let url = try endpoint.makeURL()
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = method.rawValue
        return requestUrl
    }
}

public extension NetworkRequest {
    enum HTTPMethod: String {
        case put = "PUT"
        case get = "GET"
        case post = "POST"
        case head = "HEAD"
        case delete = "DELETE"
        case patch = "PATCH"
    }
}
