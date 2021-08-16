//
//  MGENetwork
// 

import XCTest
@testable import MGENetwork

class EndpointTests: XCTestCase {
  struct TestEndpoint: Endpoint {
    var baseURL: String { "www.domain.com" }
    var path: Path { ["first", "second", "third"] }
    
    func asURL() throws -> URL {
      URL(string: completeURLString)!
    }
  }

  func testCompleteEndpointBuilding() {
    let sut: Endpoint = TestEndpoint()
    guard
      let expectedURL = URL(string: "www.domain.com/first/second/third")
    else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(try? sut.asURL(), expectedURL)
    XCTAssertEqual(sut.completeURLString, expectedURL.absoluteString)
  }
  
  func testStringEndpoint() {
    let baseURL = "www.domain.com"
    let path = ["first", "second", "third"]
    let sut = "\(baseURL)/\((path.joined(separator: "/")))"
    
    XCTAssertEqual(sut.baseURL, baseURL)
    XCTAssertEqual(sut.path, path)
    XCTAssertEqual(sut.completeURLString, sut)
  }
}
