//
//  NetworkProvider.swift
//  NBAPlayers
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

public protocol NetworkProvider {
    
    @discardableResult
    func perform<T>(_ request: NetworkRequest, completion: @escaping Completion<T, NetworkError>) -> Operation where T : Decodable 
    
}
