//
//  MGENetwork
//

import Foundation

extension String: Endpoint {
  public var baseURL: String {
    guard let url = URL(string: prependingHTTPSProtocol) else {
      Log.warning(title: "Failed creating `baseURL` from string:", message: self)
      return ""
    }

    guard let scheme = url.scheme, let host = url.host else {
      Log.warning(title: "Failed creating `baseURL` from string:", message: self)
      return ""
    }
    
    return "\(scheme)://\(host)"
  }

  public var path: Path {
    guard let url = URL(string: prependingHTTPSProtocol) else {
      return []
    }
    
    return url.path.split(separator: "/").map { String($0) }
  }
  
  public func asURL() throws -> URL {
    guard let url = URL(string: self) else {
      throw NetworkError.invalidURL
    }
    
    return url
  }
}

// MARK: - Private Helpers

private extension String {
  /// The string value of the `HTTPS` protocol.
  private static var httpsProtocol: String {
    "https://"
  }
  
  /// The string with `httpsProtocol` prepended.
  private var prependingHTTPSProtocol: String {
    hasPrefix(String.httpsProtocol) ? self : String.httpsProtocol + self
  }
}
