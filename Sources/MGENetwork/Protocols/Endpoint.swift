//
//  Endpoint.swift
//  NBAPlayers
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

public typealias HTTPHeader = [String: String]

public protocol Endpoint {
    func makeURL() throws -> URL
}
