//
//  MGENetwork
//

import Foundation

/// Models a network request.
public struct NetworkRequest {
  /// The set of HTTP methods for an HTTP request.
  public enum HTTPMethod: String {
    case put = "PUT"
    case get = "GET"
    case post = "POST"
    case head = "HEAD"
    case delete = "DELETE"
    case patch = "PATCH"
  }
  
  /// The endpoint of this request.
  public let endpoint: Endpoint
  
  /// HTTP method of this request.
  public let method: HTTPMethod
  
  public let header: HTTPHeader
  
  public init(method: HTTPMethod, endpoint: Endpoint, header: HTTPHeader) {
    self.method = method
    self.endpoint = endpoint
    self.header = header
  }
  
  /// Creates a simple get request for the given urlString.
  /// - Parameter urlString: The url string for this request.
  public init(urlString: String) {
    let endpoint = ConcreteEndpoint(urlString: urlString)
    self.init(method: .get, endpoint: endpoint, header: [:])
  }
  
  /// Generates an `URLRequest` using this network request's properties.
  /// - Throws: An error while building the `URL` object.
  /// - Returns: The `URLRequest` associated with this network request.
  public func makeURLRequest() throws -> URLRequest {
    let url = try endpoint.makeURL()
    var requestUrl = URLRequest(url: url)
    requestUrl.httpMethod = method.rawValue
    requestUrl.allHTTPHeaderFields = header
    return requestUrl
  }
}
