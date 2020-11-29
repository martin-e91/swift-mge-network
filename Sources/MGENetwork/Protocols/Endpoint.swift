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
  /// The base URL string.
  /// - Note: It should look something like `www.domain.com` or `https://domain.com`.
  var baseURL: String { get }
  
  /// The path parameters of this `Endpoint` instance.
  var path: Path  { get }
  
  /// Tries to generate an `URL` instance for this endpoint.
  /// Can throw an error while building the `URL` instance.
  func asURL() throws -> URL
}

public extension Endpoint {
  var path: Path {
    []
  }

  /// The complete URL string of this endpoint.
  var completeURLString: String {
    guard !path.isEmpty else {
      return baseURL
    }
    
    let components = [baseURL] + path
    
    return components.joined(separator: "/")
  }
}
