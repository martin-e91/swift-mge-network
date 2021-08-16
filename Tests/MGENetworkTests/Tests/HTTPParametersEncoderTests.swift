//
//  MGENetwork
// 

import XCTest
@testable import MGENetwork

final class HTTPParametersEncoderTests: XCTestCase {
  struct MockCodable: Codable, Equatable {
    let field: String
  }

  func testBodyParametersEncodingToValidJSON() throws {
    let expectedObject = MockCodable(field: "hello world!")
    
    var urlRequest = URLRequest(url: URL(string: "www.google.com")!)
    
    try HTTPParametersEncoder.encode(urlRequest: &urlRequest, with: expectedObject.asBodyParameters())
    
    guard let data = urlRequest.httpBody else {
      XCTFail("Missing httpBody")
      return
    }
    
    let sut = try JSONDecoder().decode(MockCodable.self, from: data)
    
    XCTAssertEqual(sut, expectedObject)
  }
  
  func testEmptyBodyParametersEncodingToEmptyJSON() throws {
    var urlRequest = URLRequest(url: URL(string: "www.google.com")!)
    
    try HTTPParametersEncoder.encode(urlRequest: &urlRequest, with: [String: Any]().asBodyParameters)
    
    let data = try XCTUnwrap(urlRequest.httpBody)
    let string = try XCTUnwrap(String(data: data, encoding: .utf8))
    
    XCTAssertEqual(NSString(string: string), "{\n\n}")
  }
  
  func testQueryParametersEncodingToEmptyString() throws {
    var urlRequest = URLRequest(url: URL(string: "www.google.com")!)

    try HTTPParametersEncoder.encode(urlRequest: &urlRequest, with: .query(parameters: [:]))
    
    XCTAssertTrue(queryItems(for: urlRequest).isEmpty)
  }
  
  func testSingleParameterEncodingToQueryItem() throws {
    var urlRequest = URLRequest(url: URL(string: "www.google.com")!)

    try HTTPParametersEncoder.encode(urlRequest: &urlRequest, with: .query(parameters: ["example": 1]))
    
    let expectedQueryItem = URLQueryItem(name: "example", value: "1")
    
    XCTAssertEqual(queryItems(for: urlRequest).first!, expectedQueryItem)
  }

  func testMultipleQueryParametersEncodingToQueryItems() throws {
    var urlRequest = URLRequest(url: URL(string: "www.google.com")!)

    try HTTPParametersEncoder.encode(urlRequest: &urlRequest, with: .query(parameters: ["example1": 1, "example2": 2, "example3": 3]))
    
    let expectedQueryItems = [
      URLQueryItem(name: "example1", value: "1"), URLQueryItem(name: "example2", value: "2"), URLQueryItem(name: "example3", value: "3")
    ]

    let resultQueryItems = queryItems(for: urlRequest)
    XCTAssertTrue(expectedQueryItems.allSatisfy(resultQueryItems.contains(_:)))
  }
}

// MARK: - Private Helper

private extension HTTPParametersEncoderTests {
  func queryItems(for urlRequest: URLRequest) -> [URLQueryItem] {
    URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: true)?.queryItems ?? []
  }
}
