//
//  NetworkClient.swift
//  NetworkLayer
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// A client for making network calls.
public final class NetworkClient: NetworkProvider {
    private lazy var queue = OperationQueue()
    private let session: URLSession
    
    /// Instanciates the client with the given session.
    /// - Parameter session: The session that will be used by this client. When not specified, it will  use a default configured session.
    public init(with session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    @discardableResult
    public func perform<T>(_ request: NetworkRequest, completion: @escaping Completion<T, NetworkError>) -> Operation where T : Decodable {
        let operation = DataTaskOperation<T>(session: session, request: request)
        operation.completion = completion
        queue.addOperation(operation)
        return operation
    }
    
    @discardableResult
    public func download(from urlString: String, completion: @escaping Completion<Data, NetworkError>) -> Operation {
        let operation = DownloadOperation(session: session, urlString: urlString)
        operation.completion = completion
        queue.addOperation(operation)
        return operation
    }
}
