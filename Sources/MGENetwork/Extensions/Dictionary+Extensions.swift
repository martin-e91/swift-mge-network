//
//  MGENetwork
// 

import Foundation

public extension Dictionary where Key == String {
  /// Creates a `Parameters.query` instance with the dictionary.
  var queryParameters: Parameters {
    .query(parameters: self)
  }
  
  /// Creates a `Parameters.body` instance with the dictionary.
  var bodyParameters: Parameters {
    .body(parameters: self)
  }
}
