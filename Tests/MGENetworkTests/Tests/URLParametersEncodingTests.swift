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
  
  private struct PlaceholderResponse: Decodable {}
  
  let networkProvider: NetworkProvider = NetworkClient(with: MockNetworkProviderConfiguration())
  
  func testBuildingRequestWithQueryItems() {
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
      let urlString1 = "https://postman-echo.com/get?foo1=bar1&foo2=bar2".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
      let urlString2 = "https://postman-echo.com/get?foo2=bar2&foo1=bar1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
      let expectedURL1 = URL(string: urlString1),
      let expectedURL2 = URL(string: urlString2)
    else {
      XCTFail()
      return
    }
    
    let isFirstCaseTrue = urlRequest.url?.absoluteString.caseInsensitiveCompare(expectedURL1.absoluteString) == .orderedSame
    let isSecondCaseTrue = urlRequest.url?.absoluteString.caseInsensitiveCompare(expectedURL2.absoluteString) == .orderedSame
    
    XCTAssertTrue(isFirstCaseTrue || isSecondCaseTrue)
  }
  
  func testQueryParametersCorrectness() {
    guard let url = URL(string: "www.google.com") else {
      XCTFail()
      return
    }
    
    var urlRequest = URLRequest(url: url)
    let parameters = ["foo1": "bar1", "foo2": "bar2"]
    try? URLParametersEncoder.encode(urlRequest: &urlRequest, with: parameters)
    
    guard let requestURL = urlRequest.url else {
      XCTFail()
      return
    }
    
    let expectedComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)
    
    XCTAssertEqual(expectedComponents?.queryItems?.count, parameters.count)
    XCTAssertEqual(parameters["foo1"], expectedComponents?.queryItems?.first(where: { $0.name == "foo1" })?.value)
    XCTAssertEqual(parameters["foo2"], expectedComponents?.queryItems?.first(where: { $0.name == "foo2" })?.value)
  }
  
  func testGETRequestWithQueryItems() {
    let request = NetworkRequest<Response>(
      method: .get,
      endpoint: "https://postman-echo.com/get",
      parameters: ["foo1": "bar1", "foo2": "bar2"].asQueryParameters
    )
    
    let expectation = self.expectation(description: "Response received")
    
    networkProvider.perform(request) { result in
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
  
  func testEmptyQueryParameters() {
    let endpoint = "https://postman-echo.com/get"
    let request = NetworkRequest<PlaceholderResponse>(method: .get, endpoint: endpoint)
    
    guard let urlRequest = try? request.asURLRequest() else {
      XCTFail()
      return
    }
    
    XCTAssertEqual(urlRequest.url?.absoluteString, endpoint)
  }
}
