//
//  NetworkClient.swift
//  NetworkLayer
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

public final class NetworkClient: NetworkProvider {
    private lazy var queue = OperationQueue()
    private let session: URLSession
    
    public init(with session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    public func perform<T>(_ request: NetworkRequest, completion: @escaping Completion<T, NetworkError>) -> Operation where T : Decodable {
        let operation = DataTaskOperation<T>(session: session, request: request)
        operation.completion = completion
        queue.addOperation(operation)
        return operation
    }
}
