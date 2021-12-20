//
//  MGENetwork
//

import Foundation

/// An operation that executes a completion upon its termination.
open class CompletionOperation<T, E>: AsynchronousOperation where E: Error {
  /// The block to execute when the operation finishes.
  public var completion: Completion<T, E>?
  
  /// Executes the `completion` block with a `success` result and sets the operation in the `isFinished` state.
  /// - Parameter success: The success parameter for the completion.
  public func finish(with success: T) {
    DispatchQueue.main.async {
      self.completion?(.success(success))
    }
    state = .isFinished
  }
  
  /// Executes the `completion` block with a `failure` result and sets the operation in the `isFinished` state.
  /// - Parameter error: The error parameter for the completion.
  public func finish(with error: E) {
    DispatchQueue.main.async {
      self.completion?(.failure(error))
    }
    state = .isFinished
  }
}
