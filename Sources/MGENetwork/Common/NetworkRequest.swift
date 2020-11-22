//
//  MGENetwork
//

import Foundation

/// Models a network request.
public struct NetworkRequest: Requestable {  
  public let endpoint: Endpoint
  
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
  
  public func asURLRequest() throws -> URLRequest {
    let url = try endpoint.makeURL()
    var requestUrl = URLRequest(url: url)
    requestUrl.httpMethod = method.rawValue
    requestUrl.allHTTPHeaderFields = header
    return requestUrl
  }
}
