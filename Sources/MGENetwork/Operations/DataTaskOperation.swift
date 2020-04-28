//
//  DataTaskOperation.swift
//  NetworkLayer
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

public final class DataTaskOperation<T: Decodable>: CompletionOperation<T, NetworkError> {
    private let session: URLSession
    private let request: NetworkRequest
    
    required public init(session: URLSession, request: NetworkRequest) {
        self.session = session
        self.request = request
    }
    
    public override func execute() {
        guard let urlRequest = try? request.makeURLRequest() else {
            finish(with: .invalidURL)
            return
        }
        
        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                self.finish(with: .generic(error))
            }
                        
            guard let body = data,
                let decodedData = try? self.decode(body),
                let response = response as? HTTPURLResponse else {
                    self.finish(with: .invalidData)
                    return
            }
            
            let networkResponse = NetworkResponse(body: decodedData, request: self.request, httpResponse: response)
            self.finish(with: networkResponse.body)
        }
        task.resume()
    }
    
    private func decode(_ data: Data) throws -> T? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Couldn't decode '\(T.self)': missing key '\(key.stringValue)' – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("Couldn't decode '\(T.self)': missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            print("Corrupted data")
        } catch let error {
            print("Couldn't decode '\(T.self)': \(error.localizedDescription)")
        }
        return nil
    }
}
