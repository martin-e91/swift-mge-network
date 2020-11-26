//
//  MGENetwork
// 

import XCTest
@testable import MGENetwork

final class URLParametersEncoderTests: XCTestCase {
  struct Response: Decodable {
    let args: [String: String]
    let url: String
  }
  
  let networkProvider: NetworkProvider = NetworkClient()
  
  func test_BuildingRequestWithQueryItems() {
    guard
      let domain = "https://postman-echo.com/get".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
      let url = URLComponents(string: domain)?.url
    else {
      XCTFail()
      return
    }
    
    var urlRequest = URLRequest(url: url)
    
    try? URLParametersEncoder.encode(urlRequest: &urlRequest, with: ["foo1": "bar1", "foo2": "bar2"])
    
    guard
      let urlString = "https://postman-echo.com/get?foo1=bar1&foo2=bar2".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
      let expectedURL = URL(string: urlString)
    else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(urlRequest.url?.absoluteString, expectedURL.absoluteString)
  }
  
  func test_GETRequestWithQueryItems() {
    let request = NetworkRequest(
      method: .get,
      endpoint: "https://postman-echo.com/get",
      parameters: ["foo1": "bar1", "foo2": "bar2"]
    )
    
    let expectation = self.expectation(description: "Response received")
    
    networkProvider.perform(request) { (result: Result<Response, NetworkError>) in
      switch result {
      case .failure(let error):
        XCTFail(error.message)
        
      case .success(let response):
        guard
          response.args["foo1"]?.caseInsensitiveCompare("bar1") == .some(.orderedSame),
          response.args["foo2"]?.caseInsensitiveCompare("bar2") == .some(.orderedSame)
        else {
          XCTFail()
          return
        }
        
        expectation.fulfill()
      }
    }
    
    wait(for: [expectation], timeout: 8)
  }
  
  func test_emptyQueryParameters() {
    let endpoint = "https://postman-echo.com/get"
    let request = NetworkRequest(method: .get, endpoint: endpoint)
    
    guard let urlRequest = try? request.asURLRequest() else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(urlRequest.url?.absoluteString, endpoint)
  }
  
  func test_nilValueForAParameter() {
    let endpoint = "https://postman-echo.com/get"
    let request = NetworkRequest(method: .get, endpoint: endpoint, parameters: ["some": nil])
    
    guard let urlRequest = try? request.asURLRequest() else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(urlRequest.url?.absoluteString, "https://postman-echo.com/get")
  }
}
