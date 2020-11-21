//
//  NetworkProvider.swift
//  NBAPlayers
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// An entity providing ways of making requests against the network.
public protocol NetworkProvider {
    
    /// Performs a request against the network.
    /// - Parameters:
    ///   - request: The request to process.
    ///   - completion: Completion block for handling result.
    @discardableResult
    func perform<T>(_ request: NetworkRequest, completion: @escaping Completion<T, NetworkError>) -> Operation where T : Decodable 
    
    /// Downloads raw data from the given url.
    /// - Parameters:
    ///   - url: The endpoint for the network task.
    ///   - completion: Completion block for handling result.
    @discardableResult
    func download(from urlString: String, completion: @escaping Completion<Data, NetworkError>) -> Operation
}
