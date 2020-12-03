//
//  MGENetwork
//

import Foundation

/// A response of a network call generic on the body.
struct NetworkResponse<T> where T: Decodable {
  /// This response's body object.
  let body: T
  
  /// The request associated with this response.
  let request: Requestable
  
  /// The metadata associated with the response to an HTTP protocol URL load request.
  let httpResponse: HTTPURLResponse
}
