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
  
  /// HTTP header of this request.
  var header: HTTPHeader { get }
  
  /// Converts this request to an `URLRequest`.
  /// - Throws: An error while building the `URL` object.
  /// - Returns: The `URLRequest` associated with this network request.
  func asURLRequest() throws -> URLRequest
}
