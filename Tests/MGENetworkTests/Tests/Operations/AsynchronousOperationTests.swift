//
//  MGENetwork
// 

import XCTest

@testable import MGENetwork

final class AsynchronousOperationTests: XCTestCase {
  func testOperationIsReadyWhenCreated() {
    let operation = AsynchronousOperation()
    XCTAssertEqual(operation.state, .isReady)
    XCTAssertTrue(operation.isReady)
    XCTAssertFalse(operation.isFinished)
    XCTAssertFalse(operation.isExecuting)
    XCTAssertFalse(operation.isCancelled)
  }

  func testOperationFinishesAfterStart() {
    let operation = AsynchronousOperation()
    operation.start()
    
    XCTAssertEqual(operation.state, .isFinished)
    XCTAssertTrue(operation.isFinished)
  }
  
  func testOperationReadyState() {
    let operation = AsynchronousOperation()
    operation.state = .isReady

    XCTAssertTrue(operation.isReady)
    XCTAssertFalse(operation.isFinished)
    XCTAssertFalse(operation.isExecuting)
    XCTAssertFalse(operation.isCancelled)
  }
  
  func testOperationFinishedState() {
    let operation = AsynchronousOperation()
    operation.state = .isFinished

    XCTAssertTrue(operation.isFinished)
    XCTAssertFalse(operation.isReady)
    XCTAssertFalse(operation.isExecuting)
    XCTAssertFalse(operation.isCancelled)
  }
  
  func testOperationCancelledState() {
    let operation = AsynchronousOperation()
    operation.state = .isCancelled

    XCTAssertTrue(operation.isCancelled)
    XCTAssertFalse(operation.isReady)
    XCTAssertFalse(operation.isExecuting)
    XCTAssertFalse(operation.isFinished)
  }
  
  func testOperationExecutingState() {
    let operation = AsynchronousOperation()
    operation.state = .isExecuting

    XCTAssertTrue(operation.isExecuting)
    XCTAssertFalse(operation.isReady)
    XCTAssertFalse(operation.isCancelled)
    XCTAssertFalse(operation.isFinished)
  }
}
