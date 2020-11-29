//
//  MGENetwork
// 

import Foundation

internal extension URLRequest {
  /// Adds the default headers if they're missing.
  mutating func addingDefaultHeadersIfMissing() {
    if value(forHTTPHeaderField: "Content-Type") == nil {
      setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
  }
}
