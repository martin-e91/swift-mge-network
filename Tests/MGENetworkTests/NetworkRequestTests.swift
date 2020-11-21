//
//  MGENetwork
//

import XCTest
@testable import MGENetwork

final class RequestTests: XCTestCase {
  private struct Api: Endpoint {
    func makeURL() throws -> URL {
      return URL(string: "www.google.com")!
    }
  }
  
  fileprivate var urlString: String { "www.google.com" }
  
  func testRequestCreation() {
    let api = Api()
    let method: NetworkRequest.HTTPMethod = .get
    let sut = NetworkRequest(method: method, endpoint: api)
    
    guard let urlRequest = try? sut.makeURLRequest() else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(urlRequest.url, try api.makeURL(), "Wrong resulting url")
    XCTAssertEqual(urlRequest.url?.absoluteString, urlString)
    XCTAssertEqual(urlRequest.httpMethod, method.rawValue, "Wrong resulting method")
  }
  
  func testHTTPMethodValues() {
    XCTAssertEqual(NetworkRequest.HTTPMethod.get.rawValue, "GET", "Wrong string for method")
    XCTAssertEqual(NetworkRequest.HTTPMethod.post.rawValue, "POST", "Wrong string for method")
    XCTAssertEqual(NetworkRequest.HTTPMethod.put.rawValue, "PUT", "Wrong string for method")
    XCTAssertEqual(NetworkRequest.HTTPMethod.delete.rawValue, "DELETE", "Wrong string for method")
    XCTAssertEqual(NetworkRequest.HTTPMethod.head.rawValue, "HEAD", "Wrong string for method")
    XCTAssertEqual(NetworkRequest.HTTPMethod.patch.rawValue, "PATCH", "Wrong string for method")
  }
}
