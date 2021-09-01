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
}
