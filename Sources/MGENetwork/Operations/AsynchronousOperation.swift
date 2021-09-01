//
//  MGENetwork
//

import Foundation

/// A foundation for an operation implementing a KVO-monitored state.
open class AsynchronousOperation: Operation {
  
  // MARK: - Structured Data
  
  /// The state of an `AsynchronousOperation`.
  enum State: String {
    /// The operation ready state.
    case isReady
    
    /// The operation cancelled state.
    case isCancelled
    
    /// The operation executing state.
    case isExecuting
    
    /// The operation finished state.
    case isFinished
  }
  
  // MARK: - Stored Properties
  
  /// The raw state of the operation.
  private var _state: State = .isReady
  
  /// The lock used to synchronize changes to `state`.
  private var stateLock = NSLock()
  
  // MARK: - Computed Properties
  
  /// The state of the operation.
  /// - Note: This property is thread-safe.
  var state: State {
    get {
      stateLock.lock()
      let value = _state
      stateLock.unlock()
      return value
    }
    set {
      let keyPath = "state"
      let oldValue = _state
      willChangeValue(forKey: keyPath)
      willChangeValue(forKey: newValue.rawValue)
      willChangeValue(forKey: oldValue.rawValue)
      stateLock.lock()
      _state = newValue
      stateLock.unlock()
      didChangeValue(forKey: keyPath)
      didChangeValue(forKey: newValue.rawValue)
      didChangeValue(forKey: oldValue.rawValue)
    }
  }
  
  override open var isAsynchronous: Bool {
    true
  }

  override open var isCancelled: Bool {
    state == .isCancelled
  }
  
  override open var isFinished: Bool {
    state == .isFinished
  }
  
  override open var isExecuting: Bool {
    state == .isExecuting
  }

  override open var isReady: Bool {
    state == .isReady
  }
  
  // MARK: - Functions

  override open func start() {
    guard !isCancelled else {
      state = .isFinished
      return
    }
    state = .isExecuting
    main()
  }
  
  override open func main() {
    guard !isCancelled else  {
      state = .isFinished
      return
    }
    state = .isExecuting
    execute()
  }
  
  override open func cancel() {
    super.cancel()
    state = .isCancelled
  }
  
  /// Executes the `AsynchronousOperation`.
  /// Override this method for specifying the task that the operation will execute.
  /// The base implementation does nothing and sets the operation in the `isFinished` state.
  open func execute() {
    state = .isFinished
  }
}
