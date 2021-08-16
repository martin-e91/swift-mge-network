//
//  MGENetwork
// 

import Foundation

/// An entity that can be used to describe an HTTP request.
public protocol Requestable: CustomStringConvertible {
  /// Type of the response associated with this `Requestable`.
  associatedtype ResponseType: Decodable
  
  /// The endpoint of this request.
  var endpoint: Endpoint { get }
  
  /// HTTP method of this request.
  var method: HTTPMethod { get }
  
  /// HTTP header of this request.
  var headers: HTTPHeaders { get }
  
  /// Parameters for the request, if any.
  /// - Note: for a `GET` request they are going to be encoded as url parameters.
  /// For a `POST`, `PUT` or `PATCH` request they're going to be send as body parameters.
  var parameters: Parameters { get }
  
  /// The timeout interval of the request.
  /// Default value is `30`.
  var timeoutInterval: TimeInterval { get }
  
  /// Converts this request to an `URLRequest`.
  /// - Throws: An error while building the `URL` object.
  /// - Returns: The `URLRequest` associated with this network request.
  func asURLRequest() throws -> URLRequest
}

// Default implementation

public extension Requestable {
  /// Default headers to include in a request.
  var defaultHeaders: HTTPHeaders? {
    [
      "Accept": "application/json",
      "Content-Type": "application/json"
    ]
  }
  
  var parameters: Parameters {
    .query(parameters: [:])
  }
  
  var timeoutInterval: TimeInterval {
    30
  }
  
  var description: String {
    let url = endpoint.completeURLString
    let methodString = method.rawValue
    
    return """
\(methodString) -> \(url)

Parameters:
\(parameters)
"""
  }
}
