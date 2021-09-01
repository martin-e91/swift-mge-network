//
//  MGENetwork
// 

import XCTest

extension XCTestCase {
  /// Executes the given `block` and waits for the test to fulfill the pending expectations until `timeout` expires.
  /// - Parameters:
  ///   - timeout: The time to wait for the expectations to be fulfilled.
  ///   - block: The block to be executed right before waiting.
  func executeAndWaitForExpectations(timeout: TimeInterval = 1, block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      block()
    }
    
    waitForExpectations(timeout: timeout, handler: nil)
  }
}
