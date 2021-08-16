//
//  MGENetwork
// 

import Foundation

/// Collects all the mock responses from the network.
public final class MockURLProtocol: URLProtocol {
  /// The errors that may occur with the mocked network requests.
  public enum MockNetworkRequestError: Error {
    /// The mock request is missing.
    case missingRequest
  }


  // MARK: - Static Properties
  
  /// Whether or not query parameters must be checked when distinguish between two responses.
  public static var shouldCheckQueryParameters = false
  
  /// All the requests mockable by this implementation.
  static var mockRequests: Set<MockNetworkExchange> = []
  
  // MARK: - Static Functions
  
  public override class func canInit(with request: URLRequest) -> Bool {
    true
  }
  
  public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  /// Adds the given set of requests to the mockable requests.
  /// - Parameter requests: The requests to add to the mockable set.
  public static func add(requests: Set<MockNetworkExchange>) {
    mockRequests = mockRequests.union(requests)
  }
  
  public override func startLoading() {
    defer {
      client?.urlProtocolDidFinishLoading(self)
    }

    let foundRequest = Self.mockRequests.first { [unowned self] in
      request.url?.path == $0.urlRequest.url?.path &&
        request.httpMethod == $0.urlRequest.httpMethod &&
        (Self.shouldCheckQueryParameters ? request.url?.query == $0.urlRequest.url?.query : true)
    }

    guard let mockExchange = foundRequest else {
      client?.urlProtocol(self, didFailWithError: MockNetworkRequestError.missingRequest)
      return
    }
    
    if let data = mockExchange.response.data {
      client?.urlProtocol(self, didLoad: data)
    }

    client?.urlProtocol(self, didReceive: mockExchange.urlResponse, cacheStoragePolicy: .notAllowed)
  }
  
  public override func stopLoading() {}
}
