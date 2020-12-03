//
//  MGENetwork
//

import Foundation

/// A response of a network call generic over the body.
struct NetworkResponse<BodyType> where BodyType: Decodable {
  /// This response's body object.
  let body: BodyType
  
  /// The request associated with this response.
  let request: URLRequest
  
  /// The metadata associated with the response to an HTTP protocol URL load request.
  let httpResponse: HTTPURLResponse
}
