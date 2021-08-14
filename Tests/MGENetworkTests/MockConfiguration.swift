//
//  MGENetwork
// 

import Foundation

@testable import MGENetwork

class MockURLProtocol: URLProtocol {
  /// Maps the `URL`s to the `Data` to be returned.
  static var data = [URL?: Data]()

  override class func canInit(with request: URLRequest) -> Bool {
    true
  }
  
  override func startLoading() {
    if let url = request.url {
      if let data = MockURLProtocol.data[url] {
        client?.urlProtocol(self, didLoad: data)
      }
    }
    
    client?.urlProtocolDidFinishLoading(self)
  }
  
  override func stopLoading() {}
}
