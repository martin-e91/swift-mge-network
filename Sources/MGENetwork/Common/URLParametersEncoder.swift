//
//  MGENetwork
// 

import Foundation

/// The `ParameterEncoder` for performing the encoding of query parameters for a `URLRequest`.
public enum URLParametersEncoder: ParameterEncoder {
  public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
    defer {
      urlRequest.addingDefaultHeadersIfMissing()
    }

    guard !parameters.isEmpty else {
      return
    }
    
    guard let url = urlRequest.url, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      throw NetworkError.invalidURL
    }

    components.queryItems = parameters.map { (key, value) in
      URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
    }

    urlRequest.url = components.url
  }
}
