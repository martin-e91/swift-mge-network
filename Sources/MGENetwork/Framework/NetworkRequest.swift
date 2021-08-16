//
//  MGENetwork
//

import Foundation

/// Models a network request generic over the response type.
public struct NetworkRequest<Response>: Requestable where Response: Decodable {
  public typealias ResponseType = Response
  
  public let endpoint: Endpoint
  
  public let method: HTTPMethod
  
  public let headers: HTTPHeaders
  
  public let parameters: Parameters

  public init(
    method: HTTPMethod,
    endpoint: Endpoint,
    defaultHeaders: HTTPHeaders = ["Accept": "application/json", "Content-Type": "application/json"],
    additionalHeaders: HTTPHeaders = [:],
    parameters: Parameters = .query(parameters: [:])
  ) {
    self.method = method
    self.endpoint = endpoint
    self.headers = defaultHeaders.merging(additionalHeaders) { $1 }
    self.parameters = parameters
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
    
    try addParameters(to: &urlRequest)
    
    return urlRequest
  }
  
  private func addParameters(to request: inout URLRequest) throws {
    do {
      switch parameters {
      case let .query(parameters):
        try URLParametersEncoder.encode(urlRequest: &request, with: parameters)
        
      case let .body(parameters):
        try JSONParameterEncoder.encode(urlRequest: &request, with: parameters)
        
      default:
        break
      }
    } catch {
      throw NetworkError.encodingFailure
    }
  }
}
