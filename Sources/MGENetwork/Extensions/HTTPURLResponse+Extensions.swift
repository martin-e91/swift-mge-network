//
//  MGENetwork
// 

import Foundation

internal extension HTTPURLResponse {
  /// The `HTTPStatusCode` for this `HTTPURLResponse`.
  var httpStatus: HTTPStatusCode? {
    return HTTPStatusCode(rawValue: statusCode)
  }
}
