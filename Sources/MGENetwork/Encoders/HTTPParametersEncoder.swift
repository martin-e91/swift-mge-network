//
//  MGENetwork
// 

import Foundation

/// Encodes query and body parameters for an HTTP request.
public enum HTTPParametersEncoder: ParametersEncoder {
  public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
    switch parameters {
    case let .body(parameters):
      try encodeBodyParameters(urlRequest: &urlRequest, with: parameters)
    
    case let .query(parameters):
      try encodeQueryParameters(urlRequest: &urlRequest, with: parameters)
    }
  }
}

// MARK: - Private Helpers

private extension HTTPParametersEncoder {
  /// Encodes the given `bodyParameters` into `urlRequest`.
  /// - Parameters:
  ///   - urlRequest: The url request to which add the given parameters.
  ///   - bodyParameters: The parameters to be encoded.
  /// - Throws: `NetworkError.encodingFailure`.
  private static func encodeBodyParameters(urlRequest: inout URLRequest, with bodyParameters: [String: Any]) throws {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: bodyParameters, options: .prettyPrinted)
      urlRequest.httpBody = jsonData
      urlRequest.addingDefaultHeadersIfMissing()
    } catch {
      throw NetworkError.encodingFailure
    }
  }
  
  /// Encodes the given `queryParameters` into `urlRequest`.
  /// - Parameters:
  ///   - urlRequest: The url request to which add the given parameters.
  ///   - queryParameters: The parameters to be encoded.
  /// - Throws: `NetworkError.invalidURL`.
  private static func encodeQueryParameters(urlRequest: inout URLRequest, with queryParameters: [String: Any]) throws {
    defer {
      urlRequest.addingDefaultHeadersIfMissing()
    }

    guard !queryParameters.isEmpty else {
      return
    }
    
    guard let url = urlRequest.url, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      throw NetworkError.invalidURL
    }

    components.queryItems = queryParameters.map { (key, value) in
      URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
    }

    urlRequest.url = components.url
  }
}
