//
//  MGENetwork
// 

import Foundation

/// Parameters for a `NetworkRequest`.
public enum Parameters {
  /// The query parameters for the `NetworkRequest`.
  case query(parameters: [String: Any])
  
  /// The body parameters for the `NetworkRequest`.
  case body(parameters: [String: Any])
}
