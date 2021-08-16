//
//  MGENetwork
// 

import Foundation

/// Encodes properly parameters for a request.
public protocol ParameterEncoder {
  /// Encodes the given parameters adding them to the given `URLRequest` instance.
  /// - Parameters:
  ///   - urlRequest: The `URLRequest` to which parameters are going to be added.
  ///   - parameters: The parameters to be added to the request.
  static func encode(urlRequest: inout URLRequest, with parameters: [String: Any]) throws
}
