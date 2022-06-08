//
//  MGENetwork
//

import Foundation
import Combine
import MGELogger

/// A client for making network calls.
public final class NetworkClient: NetworkProvider, OperationExecutor {
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
    let operation = networkOperation(for: request, completion: completion)
    execute(operation)
    return operation
  }

  @available(iOS 13.0, macOS 10.15, *)
  public func perform<R, T>(_ request: R) async throws -> T where R : Requestable, T == R.ResponseType {
    try await withCheckedThrowingContinuation { [weak self] continuation in
      guard let self = self else {
        return
      }

      self.perform(request) { result in
        switch result {
        case let .failure(error):
          continuation.resume(throwing: error)
          
        case let .success(response):
          continuation.resume(returning: response)
        }
      }
    }
  }

  @discardableResult
  public func download(from urlString: String, completion: @escaping Completion<Data, NetworkError>) -> Operation {
    let operation = DownloadOperation(session: session, urlString: urlString)
    operation.completion = completion
    execute(operation)
    return operation
  }
  
  public func download(from url: URL, completion: @escaping Completion<Data, NetworkError>) -> Operation {
    download(from: url.absoluteString, completion: completion)
  }
  
  public func networkOperation<R, T>(for request: R, completion: @escaping Completion<T, NetworkError>) -> Operation where R : Requestable, T == R.ResponseType {
    let operation = DataTaskOperation<R, R.ResponseType>(session: session, request: request)
    operation.completion = completion
    return operation
  }
  
  public func execute(_ operation: Operation) {
    queue.addOperation(operation)
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
