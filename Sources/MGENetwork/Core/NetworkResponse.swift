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
	
	internal init(body: BodyType, request: URLRequest, httpResponse: HTTPURLResponse) {
		self.body = body
		self.request = request
		self.httpResponse = httpResponse
	}
}

extension NetworkResponse: CustomStringConvertible {
  /// Descriptive string for this response including the `URL` and `HTTPMethod` of the associated `request`.
  var description: String {
		guard let url = request.url, let method = request.httpMethod else {
      return "Failed description for this response."
    }

    return """
\(method) \(url.absoluteString)
HTTP status: \(httpResponse.statusCode)
Decoded object:
\(body)
"""
  }
}
