//
//  DataTaskOperation.swift
//  NetworkLayer
//
//  Created by Martin Essuman on 25/04/2020.
//  Copyright © 2020 Martino Godswill Essuman. All rights reserved.
//

import Foundation

/// An operation for network calls, using data tasks generated from the given session.
/// Performs a `NetworkRequest` a completion upon its task termination.
public final class DataTaskOperation<T: Decodable>: CompletionOperation<T, NetworkError> {
  
  /// The session used by this operation.
  private let session: URLSession
  
  /// The request that will be performed by this operation.
  private let request: Requestable
  
  /// Creates a new DataTaskOperation that will use the given session for performing the given request.
  /// - Parameters:
  ///   - session: the session instance to be used by this operation.
  ///   - request: the request to be performed.
  required public init(session: URLSession, request: NetworkRequest) {
    self.session = session
    self.request = request
  }
  
  public override func execute() {
    guard let urlRequest = try? request.asURLRequest() else {
      finish(with: .invalidURL)
      return
    }
    
    Logger.log(title: "➡️ SENDING \(request.method.rawValue) Request", message: request.endpoint)
    
    let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
      guard let self = self else {
        return
      }
      
      if let error = error {
        self.finish(with: .generic(error))
      }

      Logger.log(title: "⬅️ RECEIVED RESPONSE", message: data?.prettyPrintedJSON)
      
      guard
        let body = data,
        let decodedData = try? self.decode(body),
        let response = response as? HTTPURLResponse
      else {
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
      Logger.log(
        title: "Decoding Error",
        message: "Couldn't decode '\(T.self)': missing key '\(key.stringValue)' – \(context.debugDescription)"
      )
    } catch DecodingError.valueNotFound(let type, let context) {
      Logger.log(
        title: "Decoding Error",
        message: "Couldn't decode '\(T.self)': missing \(type) value – \(context.debugDescription)"
      )
    } catch DecodingError.dataCorrupted(let context) {
      Logger.log(
        title: "Decoding Error",
        message: "Corrupted data \(context.debugDescription)"
      )
    } catch let error {
      Logger.log(
        title: "Decoding Error",
        message: "Couldn't decode '\(T.self)': \(error.localizedDescription)"
      )
    }
    return nil
  }
}
