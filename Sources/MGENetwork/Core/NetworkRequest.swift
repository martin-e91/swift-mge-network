//
//  MGENetwork
//

import Foundation

/// Models a network request generic over the response type.
public struct NetworkRequest<Response>: Requestable where Response: Decodable {
  public typealias ResponseType = Response
  
  // MARK: - Constants

  /// The default HTTP headers for the request.
  public static var defaultHeaders: HTTPHeaders {
    ["Accept": "application/json", "Content-Type": "application/json"]
  }

  // MARK: - Stored Properties

  public let endpoint: Endpoint
  
  public let method: HTTPMethod
  
  public let headers: HTTPHeaders
  
  public let parameters: Parameters
  
  public let timeoutInterval: TimeInterval
  
  // MARK: - Init
  
  /// Creates a `NetworkRequest` instance.
  /// - Parameters:
  ///   - method: The HTTP method of the request.
  ///   - endpoint: The endpoint of the request.
  ///   - defaultHeaders: The default headers of the request.
  ///   - additionalHeaders: The additional headers of the request.
  ///   - parameters: The parameters of the request.
  ///   - timeoutInterval: The timeout interval of the request.
  public init(
    method: HTTPMethod,
    endpoint: Endpoint,
    defaultHeaders: HTTPHeaders = defaultHeaders,
    additionalHeaders: HTTPHeaders = [:],
    parameters: Parameters = .query(parameters: [:]),
    timeoutInterval: TimeInterval = 30
  ) {
    self.method = method
    self.endpoint = endpoint
    self.headers = defaultHeaders.merging(additionalHeaders) { $1 }
    self.parameters = parameters
    self.timeoutInterval = timeoutInterval
  }
  
  /// Creates a simple get request for the given urlString.
  /// - Parameter urlString: The url string for this request.
  public init(urlString: String) {
    self.init(method: .get, endpoint: urlString)
  }
  
  public func asURLRequest() throws -> URLRequest {
    guard let url = try? endpoint.asURL() else {
      throw NetworkError.invalidURL
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    urlRequest.allHTTPHeaderFields = headers
    urlRequest.timeoutInterval = timeoutInterval
    
    do {
      try HTTPParametersEncoder.encode(urlRequest: &urlRequest, with: parameters)
    } catch {
      throw NetworkError.encodingFailure
    }
    
    return urlRequest
  }
}
