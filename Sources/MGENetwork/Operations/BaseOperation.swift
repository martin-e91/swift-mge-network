//
//  BaseOperation.swift
//  NetworkLayer
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// A foundation for an operation implementing a KVO-monitored state.
open class BaseOperation: Operation {
  private var _state: State = .isReady
  
  private var stateLock = NSLock()
  
  /// The state of this operation.
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
  
  override open var isAsynchronous: Bool { true }
  override open var isExecuting: Bool { state == .isExecuting }
  override open var isReady: Bool { state == .isReady }
  override open var isCancelled: Bool { state == .isCancelled }
  override open var isFinished: Bool { state == .isFinished }
  
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
  
  open func execute() {
    state = .isFinished
  }
}

public extension BaseOperation {
  enum State: String {
    case isReady
    case isCancelled
    case isExecuting
    case isFinished
  }
}
