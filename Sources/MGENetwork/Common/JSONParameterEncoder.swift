//
//  MGENetwork
// 

import Foundation

/// Encodes parameters for a request with a `JSON` body.
public enum JSONParameterEncoder: ParameterEncoder {
  public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      urlRequest.httpBody = jsonData
      urlRequest.addingDefaultHeadersIfMissing()
    } catch {
      throw NetworkError.encodingFailure
    }
  }
}
