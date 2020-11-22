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
  /// Can throw an error while building the `URL` instance.
  /// - Note: any query or path parameter must be configured inside implementation of this method.
  func asURL() throws -> URL
}
