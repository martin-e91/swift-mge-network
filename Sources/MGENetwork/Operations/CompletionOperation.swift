//
//  MGENetwork
//

import Foundation

/// The `BaseOperation` implementation for executing a completion with a `Result` right before transitioning to `isFinished` state.
open class CompletionOperation<T, E>: BaseOperation where E: Error {
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
