//
//  MGENetwork
// 

import Foundation

/// The `ParameterEncoder` for performing the encoding of parameters as `JSON` body for a `URLRequest`.
public enum JSONParameterEncoder: ParameterEncoder {
  public static func encode(urlRequest: inout URLRequest, with parameters: [String: Any]) throws {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      urlRequest.httpBody = jsonData
      urlRequest.addingDefaultHeadersIfMissing()
    } catch {
      throw NetworkError.encodingFailure
    }
  }
}
