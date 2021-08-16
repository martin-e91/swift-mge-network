//
//  MGENetwork
// 

import Foundation

public extension Dictionary where Key == String {
  /// Creates a `Parameters.query` instance with the dictionary.
  var asQueryParameters: Parameters {
    .query(parameters: self)
  }
  
  /// Creates a `Parameters.body` instance with the dictionary.
  var asBodyParameters: Parameters {
    .body(parameters: self)
  }
}
