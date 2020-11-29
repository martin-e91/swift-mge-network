//
//  ConcreteEndpoint.swift
//  NetworkLayer
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

extension String: Endpoint {
  public var baseURL: String {
    guard let baseURL = split(separator: "/").first else {
      Log.warning(title: "Failed creating `baseURL` from string:", message: "\(self)")
      return ""
    }
    
    return String(baseURL)
  }

  public var path: Path {
    split(separator: "/").dropFirst().map(String.init)
  }
  
  public func asURL() throws -> URL {
    guard let url = URL(string: self) else {
      throw NetworkError.invalidURL
    }
    
    return url
  }
}
