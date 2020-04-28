//
//  CompletionOperation.swift
//  NetworkLayer
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

public typealias Completion<T, E: Error> = (Result<T, E>) -> Void

open class CompletionOperation<T, E>: BaseOperation where E: Error {
    public var completion: Completion<T, E>?
    
    public func finish(with success: T) {
        completion?(.success(success))
        state = .isFinished
    }
    
    public func finish(with error: E) {
        completion?(.failure(error))
        state = .isFinished
    }
}
