//
//  MGENetwork
//

import Foundation

/// Models a network request.
public struct NetworkRequest: Requestable {  
  public let endpoint: Endpoint
  
  public let method: HTTPMethod
  
  public let defaultHeaders: HTTPHeaders
  
  public let additionalHeaders: HTTPHeaders
  
  public let parameters: Encodable?
  
  /// The HTTP body for the request.
  private var body: Data? {
    do {
      return try JSONSerialization.data(withJSONObject: parameters)
    } catch {
      Log.error(title: "Invalid parameters", message: error.localizedDescription)
    }
    return nil
  }
  
  public init(
    method: HTTPMethod,
    endpoint: Endpoint,
    defaultHeaders: HTTPHeaders = ["Accept": "application/json", "Content-Type": "application/json"],
    header: HTTPHeaders = [:],
    parameters: Encodable? = nil
  ) {
    self.method = method
    self.endpoint = endpoint
    self.defaultHeaders = defaultHeaders
    self.additionalHeaders = header
    self.parameters = parameters
  }
  
  /// Creates a simple get request for the given urlString.
  /// - Parameter urlString: The url string for this request.
  public init(urlString: String) {
    let endpoint = ConcreteEndpoint(urlString: urlString)
    self.init(method: .get, endpoint: endpoint, header: [:])
  }
  
  public func asURLRequest() throws -> URLRequest {
    let url = try endpoint.asURL()
    var requestUrl = URLRequest(url: url)
    requestUrl.httpMethod = method.rawValue
    requestUrl.allHTTPHeaderFields = additionalHeaders
    requestUrl.httpBody = body
    return requestUrl
  }
}
