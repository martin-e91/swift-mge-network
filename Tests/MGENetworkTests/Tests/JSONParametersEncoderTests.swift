//
//  MGENetwork
// 

import XCTest
@testable import MGENetwork

final class JSONParametersEncoderTests: XCTestCase {
  struct MockCodable: Codable, Equatable {
    let field: String
  }

  func testBodyParametersEncoding() {
    let expectedObject = MockCodable(field: "hello world!")
    
    var urlRequest = URLRequest(url: URL(string: "www.google.com")!)
    
    try? JSONParameterEncoder.encode(urlRequest: &urlRequest, with: expectedObject.asDictionary())
    
    guard
      let data = urlRequest.httpBody,
      let sut = try? JSONDecoder().decode(MockCodable.self, from: data)
    else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(sut, expectedObject)
  }
  
  func test_emptyBodyParameters() {
    var urlRequest = URLRequest(url: URL(string: "www.google.com")!)
    
    try? JSONParameterEncoder.encode(urlRequest: &urlRequest, with: [:])
    
    guard
      let data = urlRequest.httpBody,
      let sut = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any?]
    else {
      XCTFail()
      return
    }
    
    XCTAssertNotNil(sut)
    XCTAssertTrue(sut.isEmpty)
  }
}
