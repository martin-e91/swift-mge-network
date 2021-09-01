//
//  MGENetwork
// 

import XCTest

extension XCTestCase {
  /// Executes the given `block` before waiting for the given `expectation` for the specified `timeout`.
  /// - Parameters:
  ///   - expectation: The expectation to wait for.
  ///   - timeout: The time to wait for the expectations to be fulfilled.
  ///   - block: The block to be executed right before waiting.
  func waitForExpectation(_ expectation: XCTestExpectation, timeout: TimeInterval = 1, afterExecuting block: @escaping () -> Void) {
    waitForExpectations([expectation], timeout: timeout, afterExecuting: block)
  }

  /// Executes the given `block` before waiting for the given `expectations` for the specified `timeout`.
  /// - Parameters:
  ///   - expectations: The expectations to wait for.
  ///   - timeout: The time to wait for the expectations to be fulfilled.
  ///   - block: The block to be executed right before waiting.
  func waitForExpectations(_ expectations: [XCTestExpectation], timeout: TimeInterval = 1, afterExecuting block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      block()
    }
    
    wait(for: expectations, timeout: timeout)
  }
}
