//
//  MGENetwork
//

import Foundation

/// A response of a network call generic on the body.
public struct NetworkResponse<T> where T: Decodable {
  /// This response's body object.
  public let body: T
  
  /// The request associated with this response.
  public let request: NetworkRequest
  
  /// The metadata associated with the response to an HTTP protocol URL load request.
  public let httpResponse: HTTPURLResponse
}
