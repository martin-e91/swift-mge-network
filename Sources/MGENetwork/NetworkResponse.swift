//
//  NetworkResponse.swift
//  NBAPlayers
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// Models a response of a network call.
public struct NetworkResponse<T> where T: Decodable {
    /// This response's body object.
    public let body: T
    
    /// The request associated with this response.
    public let request: NetworkRequest
    
    /// The metadata associated with the response to an HTTP protocol URL load request.
    public let httpResponse: HTTPURLResponse
}
