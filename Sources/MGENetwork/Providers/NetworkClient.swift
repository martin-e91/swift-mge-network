//
//  MGENetwork
//

import Foundation
import Combine
import MGELogger

/// A client for making network calls.
public final class NetworkClient: NetworkProvider {
  /// The queue for network related operations.
  private lazy var queue = OperationQueue()
  
  /// The `URLSession` used for network tasks.
  private let session: URLSession
  
  /// Creates a new instance with the given configuration.
  /// - Parameter configuration: The configuration of the network client.
  public init(with configuration: NetworkClientConfiguration) {
    self.session = configuration.session
    Log = Logger(with: configuration.loggerConfiguration)
  }
  
  @discardableResult
  public func perform<R, T>(_ request: R, completion: @escaping Completion<T, NetworkError>) -> Operation where R : Requestable, T == R.ResponseType {
    let operation = DataTaskOperation<R, T>(session: session, request: request)
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
  
  public func download(from url: URL, completion: @escaping Completion<Data, NetworkError>) -> Operation {
    download(from: url.absoluteString, completion: completion)
  }
}

@available(iOS 13.0, macOS 10.15, *)
extension NetworkClient {
  public func download(from url: URL) -> Future<Data, NetworkError> {
    download(from: url.absoluteString)
  }
  
  public func download(from urlString: String) -> Future<Data, NetworkError> {
    Future<Data, NetworkError> { [weak self] promise in
      guard let self = self else {
        promise(.failure(.missingInstance))
        return
      }

      self.download(from: urlString) { result in
        switch result {
        case let .success(value):
          promise(.success(value))
          
        case let .failure(networkError):
          promise(.failure(networkError))
        }
      }
    }
  }
  
  public func perform<R: Requestable, T>(_ request: R) -> Future<T, NetworkError> where T == R.ResponseType {
    Future<T, NetworkError> { [weak self] promise in
      guard let self = self else {
        promise(.failure(.missingInstance))
        return
      }

      self.perform(request) { result in
        switch result {
        case let .success(value):
          promise(.success(value))
          
        case let .failure(networkError):
          promise(.failure(networkError))
        }
      }
    }
  }
}
