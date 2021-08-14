//
//  MGENetwork
// 

import Foundation

/// A mocked response, used while writing unit tests.
public struct MockResponse: Hashable {
  /// The expected response data, if any.
  public let data: Data?

  /// The headers of the mocked reponse.
  public let headers: [String: String]
  
  /// The version of the `HTTP` protocol.
  public let httpVersion: String

  /// The status code of the mock response.
  public let statusCode: Int
}
