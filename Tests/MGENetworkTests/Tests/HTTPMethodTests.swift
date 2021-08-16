//
//  MGENetwork
// 

import XCTest

@testable import MGENetwork

final class HTTPMethodTests: XCTestCase {
  func testHTTPMethodValues() {
    XCTAssertEqual(HTTPMethod.get.rawValue, "GET")
    XCTAssertEqual(HTTPMethod.post.rawValue, "POST")
    XCTAssertEqual(HTTPMethod.put.rawValue, "PUT")
    XCTAssertEqual(HTTPMethod.delete.rawValue, "DELETE")
    XCTAssertEqual(HTTPMethod.head.rawValue, "HEAD")
    XCTAssertEqual(HTTPMethod.patch.rawValue, "PATCH")
  }
}
