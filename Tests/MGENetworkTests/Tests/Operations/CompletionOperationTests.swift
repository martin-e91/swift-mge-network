//
//  MGENetwork
// 

import XCTest

@testable import MGENetwork

final class CompletionOperationTests: XCTestCase {
  func testCompletionExecutedWhenFinishingWithSuccess() {
    let operation = CompletionOperation<Bool, NSError>()

    let expectation = XCTestExpectation(description: "completion of the `CompletionOperation` must be called.")

    operation.completion = { result in
      switch result {
      case let .success(value):
        XCTAssertTrue(value)
        expectation.fulfill()

      case .failure:
        XCTFail()
      }
    }

    waitForExpectation(expectation) {
      operation.finish(with: true)
    }
  }
  
  func testCompletionExecutedWhenFinishingWithFailure() {
    let operation = CompletionOperation<Bool, NSError>()

    let expectation = XCTestExpectation(description: "completion of the `CompletionOperation` must be called.")

    operation.completion = { result in
      switch result {
      case .success:
        XCTFail()

      case let .failure(error):
        XCTAssertEqual(error, NSError(domain: #function, code: -22, userInfo: nil))
        expectation.fulfill()
      }
    }

    waitForExpectation(expectation) {
      operation.finish(with: NSError(domain: #function, code: -22, userInfo: nil))
    }
  }
}
