//
//  DownloadOperation.swift
//  NetworkLayer
//
//  Created by Martin Essuman on 23/08/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

public final class DownloadOperation: CompletionOperation<Data, NetworkError> {
    
    /// The session used by this operation.
    private let session: URLSession
    
    /// The url hit by this operation.
    private let urlString: String
    
    /// Creates a new DownloadOperation that will use the given session for downloading data from the specified url.
    /// - Parameters:
    ///   - session: the session instance to be used by this operation.
    ///   - urlString: the url used by this operation.
    required public init(session: URLSession, urlString: String) {
        self.session = session
        self.urlString = urlString
    }
    
    public override func execute() {
        guard let url = URL(string: urlString) else {
            return finish(with: .invalidURL)
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.finish(with: .generic(error))
                return
            }
            
            guard let data = data else {
                self.finish(with: NetworkError.invalidData)
                return
            }
            self.finish(with: data)
        }
        task.resume()
    }
}
