//
//  MGENetwork
//

import XCTest
@testable import MGENetwork

final class RequestTests: XCTestCase {
  private struct Api: Endpoint {
    func asURL() throws -> URL {
      return URL(string: "www.google.com")!
    }
  }
  
  fileprivate var urlString: String { "www.google.com" }
  
  func testRequestCreation() {
    let api = Api()
    let method: HTTPMethod = .get
    let sut = NetworkRequest(method: method, endpoint: api)
    
    guard let urlRequest = try? sut.asURLRequest() else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(urlRequest.url, try api.asURL(), "Wrong resulting url")
    XCTAssertEqual(urlRequest.url?.absoluteString, urlString)
    XCTAssertEqual(urlRequest.httpMethod, method.rawValue, "Wrong resulting method")
  }
  
  func testHTTPMethodValues() {
    XCTAssertEqual(HTTPMethod.get.rawValue, "GET", "Wrong string for method")
    XCTAssertEqual(HTTPMethod.post.rawValue, "POST", "Wrong string for method")
    XCTAssertEqual(HTTPMethod.put.rawValue, "PUT", "Wrong string for method")
    XCTAssertEqual(HTTPMethod.delete.rawValue, "DELETE", "Wrong string for method")
    XCTAssertEqual(HTTPMethod.head.rawValue, "HEAD", "Wrong string for method")
    XCTAssertEqual(HTTPMethod.patch.rawValue, "PATCH", "Wrong string for method")
  }
}
