//
//  MGENetwork
// 

import Foundation

/// An entity that can be used to describe an HTTP request.
public protocol Requestable {
  /// The endpoint of this request.
  var endpoint: Endpoint { get }
  
  /// HTTP method of this request.
  var method: HTTPMethod { get }
  
  /// Default headers for the request.
  var defaultHeaders: HTTPHeaders { get }
  
  /// HTTP header of this request.
  var additionalHeaders: HTTPHeaders { get }
  
  /// Body parameters for the request, if any.
  var parameters: Encodable? { get }
  
  /// Converts this request to an `URLRequest`.
  /// - Throws: An error while building the `URL` object.
  /// - Returns: The `URLRequest` associated with this network request.
  func asURLRequest() throws -> URLRequest
}

public extension Requestable {
  var defaultHeaders: HTTPHeaders? {
    [
      "Accept": "application/json",
      "Content-Type": "application/json"
    ]
  }
}
