//
//  MGENetwork
//

import Foundation

/// A response of a network call generic over the body.
internal struct NetworkResponse<BodyType> where BodyType: Decodable {
  /// This response's body object.
  let body: BodyType
  
  /// The request associated with this response.
  let request: URLRequest
  
  /// The metadata associated with the response to an HTTP protocol URL load request.
  let httpResponse: HTTPURLResponse
}

extension NetworkResponse: CustomStringConvertible {
  /// The descriptive string for this response including the `URL` and `HTTPMethod` of the associated `request`.
  var description: String {
    guard let url = request.url, let method = request.httpMethod else {
      return "Failed description for this response."
    }
    
    return """
\(method) -> \(url.absoluteString)

Body:

\(body)
"""
  }
}
