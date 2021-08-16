//
//  MGENetwork
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
    split(separator: "/").dropFirst().map { String($0) }
  }
  
  public func asURL() throws -> URL {
    guard let url = URL(string: self) else {
      throw NetworkError.invalidURL
    }
    
    return url
  }
}
