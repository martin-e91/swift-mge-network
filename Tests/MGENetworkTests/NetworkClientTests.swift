//
//  MGENetwork
// 

import XCTest
@testable import MGENetwork

final class NetworkClientTests: XCTestCase {
  let client: NetworkProvider = NetworkClient(with: MockNetworkProviderConfiguration())
  
  func test_SuccesfulDownload() {
    let urlString = "https://assets.chucknorris.host/img/avatar/chuck-norris.png"
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
