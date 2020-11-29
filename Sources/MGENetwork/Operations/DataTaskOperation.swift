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
  required public init(session: URLSession, request: Requestable) {
    self.session = session
    self.request = request
  }
  
  public override func execute() {
    guard let urlRequest = try? request.asURLRequest() else {
      Log.error(title: "Invalid URL", message: NetworkError.invalidURL.message)
      finish(with: .invalidURL)
      return
    }
    
    Log.debug(title: "➡️ SENDING \(request.method.rawValue) Request", message: "to \(request.endpoint)")
    
    let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
      guard let self = self else {
        return
      }
      
      if let error = error {
        Log.error(title: "An error occurred", message: "\(error.localizedDescription)")
        self.finish(with: .generic(error))
      }
     
      Log.debug(title: "⬅️ RECEIVED RESPONSE", message: data?.prettyPrintedJSON ?? "")
      
      guard
        let body = data,
        let decodedData = try? self.decode(body),
        let response = response as? HTTPURLResponse
      else {
        Log.error(title: "Invalid data", message: NetworkError.invalidData.message)
        self.finish(with: .invalidData)
        return
      }
      
      if let clientError = self.clientError(from: response.httpStatus) {
        Log.error(title: "Client Error", message: clientError.message)
        self.finish(with: clientError)
      }
            
      let networkResponse = NetworkResponse(body: decodedData, request: self.request, httpResponse: response)
      self.finish(with: networkResponse.body)
    }
    task.resume()
  }
  
  /// Calls `finish` with an error associated with the `HTTPStatusCode`.
  /// - Parameter statusCode: the statusCode received by the server.
  private func clientError(from statusCode: HTTPStatusCode?) -> NetworkError? {
    guard statusCode?.responseType == .some(.clientError) else {
      return nil
    }
    
    switch statusCode {
    case .badRequest:
      return .badRequest
      
    case .forbidden:
      return .forbidden
      
    case .notFound:
      return .notFound
      
    case .unauthorized:
      return .unauthorized
      
    default:
      return .unknown
    }
  }
  
  private func decode(_ data: Data) throws -> T? {
    let decoder = JSONDecoder()
    
    do {
      let decodedData = try decoder.decode(T.self, from: data)
      return decodedData
    } catch DecodingError.keyNotFound(let key, let context) {
      Log.debug(
        title: "Couldn't decode '\(T.self)",
        message: "Missing key '\(key.stringValue)' – \(context.debugDescription)"
      )
    } catch DecodingError.valueNotFound(let type, let context) {
      Log.debug(
        title: "Couldn't decode '\(T.self)'",
        message: "missing \(type) value – \(context.debugDescription)"
      )
    } catch DecodingError.dataCorrupted(let context) {
      Log.debug(title: "Corrupted data", message: "\(context.debugDescription)")
    } catch let error {
      Log.debug(title: "Couldn't decode '\(T.self)'", message: "\(error.localizedDescription)")
    }
    return nil
  }
}
