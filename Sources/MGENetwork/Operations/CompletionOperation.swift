//
//  CompletionOperation.swift
//  NetworkLayer
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// A completion to handle a result or an error.
public typealias Completion<T, E: Error> = (Result<T, E>) -> Void

/// An operation that executes a completion upon its termination.
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
