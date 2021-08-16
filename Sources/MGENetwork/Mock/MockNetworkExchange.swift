//
//  MGENetwork
// 

import Foundation

/// Associates an `URLRequest` to a `MockResponse`.
public struct MockNetworkExchange: Hashable {
  /// The `URLRequest` associated to the request.
  public let urlRequest: URLRequest

  /// The mocked response associated to the `urlRequest`.
  public let response: MockResponse

  /// The expected `HTTPURLResponse`.
  public var urlResponse: HTTPURLResponse {
    HTTPURLResponse(
      url: urlRequest.url!,
      statusCode: response.statusCode,
      httpVersion: response.httpVersion,
      // Merges existing headers, if any, with the custom mock headers favoring the latter.
      headerFields: (urlRequest.allHTTPHeaderFields ?? [:]).merging(response.headers) { $1 }
    )!
  }

  public init(urlRequest: URLRequest, response: MockResponse) {
    self.urlRequest = urlRequest
    self.response = response
  }
}
