//
//  MGENetwork
//

import Foundation

/// A response of a network call generic on the body.
struct NetworkResponse<RequestType, BodyType> where BodyType: Decodable {
  /// This response's body object.
  let body: BodyType
  
  /// The request associated with this response.
  let request: RequestType
  
  /// The metadata associated with the response to an HTTP protocol URL load request.
  let httpResponse: HTTPURLResponse
}
