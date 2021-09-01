//
//  MGENetwork
// 

import XCTest

@testable import MGENetwork

final class DataTaskOperationTests: XCTestCase {
  private struct MockRequestable: Requestable {
    typealias ResponseType = Bool

    var endpoint: Endpoint = "www.fakeendpoint.com"
    
    var method: HTTPMethod = .get
    
    var headers: HTTPHeaders = [:]
    
    func asURLRequest() throws -> URLRequest {
      URLRequest(url: try endpoint.asURL())
    }
  }
  
  override class func setUp() {
    MockURLProtocol.add(requests: [MockNetworkExchange(urlRequest: try! MockRequestable().asURLRequest(), response: MockResponse(data: true.encoded, headers: [:], httpVersion: "", statusCode: 200))])
  }

  func testRequestIsPerformed() {
    let session = MockNetworkProviderConfiguration().session
    
    let operation = DataTaskOperation<MockRequestable, Bool>(session: session, request: MockRequestable())
    
    let expectation = expectation(description: "the mock request shall be performed")
    
    operation.completion = { result in
      switch result {
      case let .success(value):
        XCTAssertTrue(value)
        expectation.fulfill()
        
      case let .failure(error):
        XCTFail(error.localizedDescription)
      }
    }
    
    executeAndWaitForExpectations {
      operation.start()
    }
  }
}
