//
//  MGENetwork
//

import Foundation

/// An operation that executes a completion upon its termination.
open class CompletionOperation<T, E>: AsynchronousOperation where E: Error {
  public var completion: Completion<T, E>?
  
  public func finish(with success: T) {
    DispatchQueue.main.async {
      self.completion?(.success(success))
    }
    state = .isFinished
  }
  
  public func finish(with error: E) {
    DispatchQueue.main.async {
      self.completion?(.failure(error))
    }
    state = .isFinished
  }
}
