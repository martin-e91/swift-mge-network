//
//  Endpoint.swift
//  NBAPlayers
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// An endpoint provider.
public protocol Endpoint {
  /// Tries to generate an `URL` instance for this endpoint.
  /// Can throw error related to building the `URL` instance.
  func makeURL() throws -> URL
}
