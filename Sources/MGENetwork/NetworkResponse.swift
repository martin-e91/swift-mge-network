//
//  NetworkResponse.swift
//  NBAPlayers
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

public struct NetworkResponse<T> where T: Decodable {
    public let body: T
    public let request: NetworkRequest
    public let httpResponse: HTTPURLResponse
}
