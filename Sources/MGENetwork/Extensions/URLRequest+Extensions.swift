//
//  MGENetwork
// 

import Foundation

internal extension URLRequest {
  /// Adds the `Content-Type` header with `application/json` value if it's missing.
  mutating func addingDefaultHeadersIfMissing() {
    if value(forHTTPHeaderField: "Content-Type") == nil {
      setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
  }
}
