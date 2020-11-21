//
//  Endpoint.swift
//  NBAPlayers
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// A type for representing HTTP header fields.
public typealias HTTPHeader = [String: String]

/// An endpoint provider.
public protocol Endpoint {
    /// Tries to generate an `URL` instance for this endpoint.
    func makeURL() throws -> URL
}
