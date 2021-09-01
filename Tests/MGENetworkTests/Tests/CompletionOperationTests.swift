//
//  MGENetwork
// 

import XCTest

@testable import MGENetwork

final class CompletionOperationTests: XCTestCase {
  func testCompletionExecutedWhenFinishingWithSuccess() {
    let operation = CompletionOperation<Bool, NSError>()

    let expectation = expectation(description: "completion of the `CompletionOperation` must be called.")

    operation.completion = { result in
      switch result {
      case let .success(value):
        XCTAssertTrue(value)
        expectation.fulfill()

      case .failure:
        XCTFail()
      }
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      operation.finish(with: true)
    }
    
    waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testCompletionExecutedWhenFinishingWithFailure() {
    let operation = CompletionOperation<Bool, NSError>()

    let expectation = expectation(description: "completion of the `CompletionOperation` must be called.")

    operation.completion = { result in
      switch result {
      case .success:
        XCTFail()

      case let .failure(error):
        XCTAssertEqual(error, NSError(domain: #function, code: -22, userInfo: nil))
        expectation.fulfill()
      }
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      operation.finish(with: NSError(domain: #function, code: -22, userInfo: nil))
    }
    
    waitForExpectations(timeout: 1, handler: nil)
  }
}
