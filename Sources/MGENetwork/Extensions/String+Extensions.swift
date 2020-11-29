//
//  ConcreteEndpoint.swift
//  NetworkLayer
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

extension String: Endpoint {
  public func asURL() throws -> URL {
    guard let url = URL(string: self) else {
      throw NetworkError.invalidURL
    }
    
    return url
  }
}
