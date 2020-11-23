//
//  MGENetwork
// 

import Foundation

/// Encodes parameters for a request with a `JSON` body.
public struct JSONParameterEncoder: ParameterEncoder {
  public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      urlRequest.httpBody = jsonData
      
      // Adds the correct header if it's missing
      if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
      }
    } catch {
      throw NetworkError.encodingFailure
    }
  }
}
