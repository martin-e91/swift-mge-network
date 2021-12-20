//
//  MGENetwork
//

import XCTest

@testable import MGENetwork

final class RequestTests: XCTestCase {
  private struct Api: Endpoint {
    var baseURL: String { "www.mockAddress.com" }
    
    func asURL() throws -> URL {
      return URL(string: baseURL)!
    }
  }
  
  /// Struct for testing with the Postman api
  private struct POSTBody: Codable, Equatable {
    let message: String
  }
  
  private struct Response: Decodable {
    let json: POSTBody
  }
  
  /// Used when the response type can be ignored in the test.
  private struct PlaceholderResponse: Decodable {}

  func testURLRequestCreation() throws {
    let methods: [HTTPMethod] = [.get, .head, .post, .put, .patch, .delete]
    
    try methods.forEach { method in
      let sut = NetworkRequest<PlaceholderResponse>(
        method: method,
        endpoint: "www.test.com",
        defaultHeaders: ["default": "first"],
        additionalHeaders: ["additional": "header"],
        parameters: try POSTBody(message: "test").asBodyParameters(),
        timeoutInterval: 10
      )

      XCTAssertEqual(sut.method, method)
      XCTAssertEqual(sut.endpoint.baseURL, "www.test.com".baseURL)
      XCTAssertEqual(sut.endpoint.completeURLString, "www.test.com".completeURLString)
      XCTAssertEqual(sut.endpoint.path, "www.test.com".path)
      XCTAssertEqual(try sut.endpoint.asURL(), try "www.test.com".asURL())
      XCTAssertEqual(sut.headers, ["default": "first", "additional": "header"])
      XCTAssertEqual(sut.timeoutInterval, 10)
      
      switch sut.parameters {
      case let .body(parameters):
        XCTAssertEqual(parameters.nsDictionary, ["message": "test"].nsDictionary)
        
      case .query:
        XCTFail()
      }
    }
  }
  
  func testNilBodyParameterWhenNotSpecified() throws {
    let request = NetworkRequest<PlaceholderResponse>(method: .get, endpoint: "www.google.com")
    let urlRequest = try request.asURLRequest()
    XCTAssertNil(urlRequest.httpBody, "Body must be nil for GET requests")
  }
  
  func testBodyParametersEncoding() throws {
    let expectedObject = POSTBody(message: "hello")
    
    let parameters = try expectedObject.asBodyParameters()
    
    let request = NetworkRequest<PlaceholderResponse>(method: .post, endpoint: "www.google.com", parameters: parameters)
    let urlRequest = try request.asURLRequest()
    let body = try XCTUnwrap(urlRequest.httpBody)

    let sut = try JSONDecoder().decode(POSTBody.self, from: body)
     
    XCTAssertEqual(sut, expectedObject)
  }
}
