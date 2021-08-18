//
//  MGENetwork
// 

import Foundation

/// An encoder of `Parameters`.
public protocol ParametersEncoder {
  /// Encodes the given `parameters` and adds them to the given `URLRequest` instance.
  ///
  /// - Parameters:
  ///   - urlRequest: The `URLRequest` to which add parameters.
  ///   - parameters: The parameters to be encoded.
  static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
