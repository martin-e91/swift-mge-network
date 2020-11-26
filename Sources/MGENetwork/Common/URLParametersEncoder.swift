//
//  MGENetwork
// 

import Foundation

public enum URLParametersEncoder: ParameterEncoder {
  public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
    defer {
      urlRequest.addingDefaultHeadersIfMissing()
    }

    guard !parameters.isEmpty else {
      return
    }
    
    guard
      let url = urlRequest.url,
      var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    else {
      throw NetworkError.invalidURL
    }

    components.queryItems = [URLQueryItem]()
    
    for (key, value) in parameters {
      guard let unwrappedValue = value else {
        Log.warning(title: "Invalid query parameter", message: "Discarded value '\(value)' for parameter '\(key)'")
        continue
      }
      
      let queryItem = URLQueryItem(name: key, value: "\(unwrappedValue)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
      components.queryItems?.append(queryItem)
    }

    urlRequest.url = components.url
  }
}
