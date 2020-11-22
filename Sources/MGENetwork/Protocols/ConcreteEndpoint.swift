//
//  ConcreteEndpoint.swift
//  NetworkLayer
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// A simple endpoint representation.
public struct ConcreteEndpoint: Endpoint {
    public let urlString: String
    public let queryParameters: [URLQueryItem]
    
    public init(urlString: String, queryParameters: [URLQueryItem] = []) {
        self.urlString = urlString
        self.queryParameters = queryParameters
    }
    
    public func makeURL() throws -> URL {
        var components = URLComponents(string: urlString)
        components?.queryItems = queryParameters
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        return url
    }
}
