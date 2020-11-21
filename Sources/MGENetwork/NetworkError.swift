//
//  NetworkError.swift
//  NBAPlayers
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// Error occurring upon network tasks.
public enum NetworkError: Error {
    case invalidURL
    case invalidData
    case generic(Error)
}
