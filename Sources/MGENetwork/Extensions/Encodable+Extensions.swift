//
//  MGENetwork
// 

import Foundation

internal extension Encodable {
  /// Try to create a `Parameters.body` instance from the `Encodable` instance.
  /// - Throws: `NetworkError.encodingFailure`
  /// - Returns: The `Parameters.body` instance if the encode succeeds.
  func asBodyParameters() throws -> Parameters {
    .body(parameters: try asDictionary())
  }

  /// Try to create a dictionary instance from this `Encodable` object.
  /// - Throws: `NetworkError.encodingFailure`
  /// - Returns: a dictionary instance from this `Encodable` object.
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)

    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NetworkError.encodingFailure
    }

    return dictionary
  }
  
  /// Try to create a `Parameters.query` instance from the `Encodable` instance.
  /// - Throws: `NetworkError.encodingFailure`
  /// - Returns: The `Parameters.query` instance if the encode succeeds.
  func asQueryParameters() throws -> Parameters {
    .query(parameters: try asDictionary())
  }
}
