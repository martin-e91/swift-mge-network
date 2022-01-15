//
//  MGENetwork
// 

import XCTest
@testable import MGENetwork

final class NetworkClientTests: XCTestCase {
  let client: NetworkProvider = NetworkClient(with: MockNetworkProviderConfiguration())
  
  override class func setUp() {
    MockURLProtocol.add(
      requests: [
        MockNetworkExchange(
          urlRequest: URLRequest(url: URL(string: "https://testSuccesfulDownload.com")!),
          response: MockResponse(data: nil, headers: [:], httpVersion: "", statusCode: 200)
        )
      ]
    )
  }
  
  func testSuccesfulDownload() {
    let urlString = "https://testSuccesfulDownload.com"
    let expectation = XCTestExpectation(description: "Download Expectation")
    
    client.download(from: urlString) { (result: Result<Data, NetworkError>) in
      switch result {
      case .success(_):
        expectation.fulfill()
      
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
    
    wait(for: [expectation], timeout: 5)
  }
  
  func testNetworkOperationBuilding() {
    let mockRequest = MockRequestable()
    let networkOperation = client.networkOperation(for: mockRequest, completion: { _ in
      XCTFail("The new operation must be into ready state without being executed.")
    })
    
    XCTAssertTrue(networkOperation.isReady)
    XCTAssertTrue(networkOperation.isAsynchronous)
    XCTAssertFalse(networkOperation.isCancelled)
    XCTAssertFalse(networkOperation.isExecuting)
    XCTAssertFalse(networkOperation.isFinished)
  }

  func testNetworkOperationExecution() {
    let expectation = XCTestExpectation(description: "Execution Expectation")

    let networkOperation = client.networkOperation(for: MockRequestable(), completion: { result in
      switch result {
      case .success(_):
        expectation.fulfill()
      
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    })
    
    client.execute(networkOperation)

    wait(for: [expectation], timeout: 5)
  }
}

fileprivate struct MockRequestable: Requestable {
  typealias ResponseType = Bool

  var endpoint: Endpoint = "www.fakeendpoint.com"
  
  var method: HTTPMethod = .get
  
  var headers: HTTPHeaders = [:]
  
  func asURLRequest() throws -> URLRequest {
    URLRequest(url: try endpoint.asURL())
  }
}
