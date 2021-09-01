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
  
  func testStringEndpointWithoutTransferProtocol() throws {
    let sut = "www.domain.com/first/second/third"

    XCTAssertEqual(sut.baseURL, "https://www.domain.com")
    XCTAssertEqual(sut.path, ["first", "second", "third"])
    XCTAssertEqual(sut.completeURLString, "https://www.domain.com/first/second/third")
    XCTAssertEqual(try sut.asURL().absoluteString, "www.domain.com/first/second/third")
  }
  
  func testStringEndopintWithTransferProtocol() throws {
    let sut = "https://www.domain.com/first/second/third"
    
    XCTAssertEqual(sut.baseURL, "https://www.domain.com")
    XCTAssertEqual(sut.path, ["first", "second", "third"])
    XCTAssertEqual(sut.completeURLString, "https://www.domain.com/first/second/third")
    XCTAssertEqual(try sut.asURL().absoluteString, "https://www.domain.com/first/second/third")
  }
}
