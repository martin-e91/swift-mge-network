//
//  MGENetwork
//

import XCTest
@testable import MGENetwork

final class RequestTests: XCTestCase {
  private struct Api: Endpoint {
    var baseURL: String { "www.google.com" }
    
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
  
  fileprivate var urlString: String { "www.google.com" }
  
  let networkClient: NetworkProvider = {
    var client = NetworkClient()
    client.isLoggingEnabled = false
    return client
  }()
  
  func test_GETRequestCreation() {
    let api = Api()
    let methods: [HTTPMethod] = [.get, .head, .post, .put, .patch, .delete]
    
    try? methods.forEach { method in
      let sut = NetworkRequest<PlaceholderResponse>(method: method, endpoint: api)
      
      guard let urlRequest = try? sut.asURLRequest() else {
        XCTFail()
        return
      }
      
      XCTAssertEqual(urlRequest.allHTTPHeaderFields, sut.headers)
      XCTAssertEqual(urlRequest.url, try api.asURL(), "Wrong resulting url")
      XCTAssertEqual(urlRequest.url?.absoluteString, urlString)
      XCTAssertEqual(urlRequest.httpMethod, method.rawValue, "Wrong resulting method")
    }
  }
  
  func test_HTTPMethodValues() {
    XCTAssertEqual(HTTPMethod.get.rawValue, "GET", "Wrong string for method")
    XCTAssertEqual(HTTPMethod.post.rawValue, "POST", "Wrong string for method")
    XCTAssertEqual(HTTPMethod.put.rawValue, "PUT", "Wrong string for method")
    XCTAssertEqual(HTTPMethod.delete.rawValue, "DELETE", "Wrong string for method")
    XCTAssertEqual(HTTPMethod.head.rawValue, "HEAD", "Wrong string for method")
    XCTAssertEqual(HTTPMethod.patch.rawValue, "PATCH", "Wrong string for method")
  }
  
  func test_POSTRequest() {
    let request = NetworkRequest<Response>(method: .post, endpoint: "https://postman-echo.com/post", parameters: ["message": "Ciao Postman 👋🏾"])
    
    let expectation = XCTestExpectation(description: "Successful POST Request")
    
    networkClient.perform(request) { result in
      switch result {
      case .failure(let error):
        XCTFail(error.message)
        
      case .success(let response):
        print(response)
        expectation.fulfill()
      }
    }
    
    wait(for: [expectation], timeout: 10)
  }
  
  func test_BodyParameterIsNilForGETRequests() {
    let request = NetworkRequest<PlaceholderResponse>(method: .get, endpoint: "www.google.com")
    
    guard let urlRequest = try? request.asURLRequest() else {
      XCTFail()
      return
    }
    
    XCTAssertNil(urlRequest.httpBody, "Body must be nil for GET requests")
  }
  
  func test_BodyParametersEncoding() {
    let expectedObject = POSTBody(message: "hello")
    
    guard let parameters = try? expectedObject.asDictionary() else {
      XCTFail()
      return
    }
    
    let request = NetworkRequest<PlaceholderResponse>(
      method: .post,
      endpoint: "www.google.com",
      parameters: parameters
    )
  
    guard
      let urlRequest = try? request.asURLRequest(),
      let body = urlRequest.httpBody,
      let sut = try? JSONDecoder().decode(POSTBody.self, from: body)
    else {
      XCTFail()
      return
    }
     
    XCTAssertEqual(sut, expectedObject)
  }
}
