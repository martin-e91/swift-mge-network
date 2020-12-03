//
//  MGENetwork
// 

import Foundation

extension HTTPURLResponse {
  /// The `HTTPStatusCode` for this `HTTPURLResponse`.
  var httpStatus: HTTPStatusCode? {
    return HTTPStatusCode(rawValue: statusCode)
  }
}
