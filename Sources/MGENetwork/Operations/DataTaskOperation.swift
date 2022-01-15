//
//  MGENetwork
//

import Foundation

/// An operation for network calls, using data tasks generated from the given session.
/// Performs a `NetworkRequest` a completion upon its task termination.
public final class DataTaskOperation<RequestType, DataType>: CompletionOperation<DataType, NetworkError>, NetworkOperation where RequestType: Requestable, RequestType.ResponseType == DataType {
  /// The session used by this operation.
  private let session: URLSession
  
  /// The request that will be performed by this operation.
  private let request: RequestType
  
  /// Creates a new DataTaskOperation that will use the given session for performing the given request.
  /// - Parameters:
  ///   - session: the session instance to be used by this operation.
  ///   - request: the request to be performed.
  required public init(session: URLSession, request: RequestType) {
    self.session = session
    self.request = request
  }
  
  /// Performs the `request` against the network using the given `session`.
  public override func execute() {
    guard let urlRequest = try? request.asURLRequest() else {
      finish(with: .invalidURL)
      return
    }
    
    Log.debug(title: "➡️ SENDING REQUEST", message: "\(request)")
    
    let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
      guard let self = self else {
        return
      }
      
      if let error = error {
        Log.error(title: "An error occurred", message: "\(error.localizedDescription)")
        self.finish(with: .generic(error))
      }

      Log.debug(title: "⬅️ RECEIVED RESPONSE", message: data?.prettyPrintedJSON?.string ?? "")
      
      guard let body = data, let decodedData = self.decode(body), let response = response as? HTTPURLResponse else {
        self.finish(with: .invalidData)
        return
      }
      
      if let clientError = self.clientError(from: response.httpStatus) {
        Log.error(title: "Client Error", message: clientError.message)
        self.finish(with: clientError)
      }
            
      let networkResponse = NetworkResponse(body: decodedData, request: urlRequest, httpResponse: response)
      
      Log.debug(title: "DECODED RESPONSE", message: networkResponse.description)
      
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
  
  /// Tries decoding the given data into a `DataType`.
  /// - Parameter data: The raw data to be decoded.
  /// - Returns: The decoded data type upon success, `nil` elsewhere.
  private func decode(_ data: Data) -> DataType? {
    do {
      let decodedData = try JSONDecoder().decode(DataType.self, from: data)
      return decodedData
    } catch DecodingError.keyNotFound(let key, let context) {
      Log.debug(
        title: "Couldn't decode '\(DataType.self)",
        message: "Missing key '\(key.stringValue)' – \(context.debugDescription)"
      )
    } catch DecodingError.valueNotFound(let type, let context) {
      Log.debug(
        title: "Couldn't decode '\(DataType.self)'",
        message: "missing \(type) value – \(context.debugDescription)"
      )
    } catch DecodingError.dataCorrupted(let context) {
      Log.debug(title: "Corrupted data", message: "\(context.debugDescription)")
    } catch let error {
      Log.debug(title: "Couldn't decode '\(DataType.self)'", message: "\(error.localizedDescription)")
    }

    return nil
  }
}
