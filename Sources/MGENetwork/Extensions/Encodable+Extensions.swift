//
//  MGENetwork
// 

import Foundation

public extension Encodable {
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
}
