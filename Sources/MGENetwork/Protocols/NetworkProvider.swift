//
//  MGENetwork
//

import Foundation
#if canImport(Combine)
import Combine
#endif

/// An entity providing ways of making requests against the network.
public protocol NetworkProvider: OperationExecutor {
  /// Whether the logging is enabled or not. Default value is `true`.
  var isLoggingEnabled: Bool { get set }

  /// Downloads raw data from the given `urlString`.
  /// - Parameters:
  ///   - urlString: The endpoint for the network task.
  ///   - completion: Completion block for handling result.
  ///  - Returns: An `Operation` managing the network task of the request.
  @discardableResult
  func download(from urlString: String, completion: @escaping Completion<Data, NetworkError>) -> Operation
  
  /// Downloads raw data from the given `url`.
  /// - Parameters:
  ///   - url: The endpoint `URL` for the network task.
  ///   - completion: Completion block for handling result.
  ///  - Returns: An `Operation` managing the network task of the request.
  @discardableResult
  func download(from url: URL, completion: @escaping Completion<Data, NetworkError>) -> Operation
  
  /// Downloads raw data from the given `urlString` wrapping the result in a `Future` instance.
  /// - Parameters:
  ///   - urlString: The endpoint for the network task.
  ///  - Returns: A `Future` resolving with either the decoded value or a `NetworkError`.
  @available(iOS 13.0, macOS 10.15, *)
  func download(from urlString: String) -> Future<Data, NetworkError>
  
  /// Downloads raw data from the given `url` wrapping the result in a `Future` instance.
  /// - Parameters:
  ///   - url: The endpoint `URL` for the network task.
  ///  - Returns: A `Future` resolving with either the decoded value or a `NetworkError`.
  @available(iOS 13.0, macOS 10.15, *)
  func download(from url: URL) -> Future<Data, NetworkError>
  
  /// Downloads raw data from the given `url` returning the result asynchronously.
  /// - Parameters:
  ///   - url: The endpoint `URL` for the network task.
  ///  - Returns: A `Future` resolving with either the decoded value or a `NetworkError`.
  ///  - Throws: `NetworkError`.
  @available(iOS 13.0, macOS 10.15, *)
  func download(from url: URL) async throws -> Data
  
  /// Creates a network request operation and returns it without executing.
  ///
  /// - Parameters:
  ///   - request: The request the operation will execute.
  ///   - completion: Completion block for handling result.
  ///  - Returns: An `Operation` managing the network task of the request.
  func networkOperation<R: Requestable, T>(
    for request: R,
    completion: @escaping Completion<T, NetworkError>
  ) -> Operation where R.ResponseType == T

  /// Performs the given `request` against the network returning the `Operation` instance that manages it.
  /// - Parameters:
  ///   - request: The request to process.
  ///   - completion: Completion block for handling result.
  ///  - Returns: An `Operation` managing the network task of the request.
  @discardableResult
  func perform<R: Requestable, T>(_ request: R, completion: @escaping Completion<T, NetworkError>) -> Operation where R.ResponseType == T
  
  /// Performs the given `request` against the network wrapping its result in a `Future` instance.
  ///   - Parameter request: The request to process.
  /// - Returns: A `Future` resolving with either the decoded value or a `NetworkError`.
  @available(iOS 13.0, macOS 10.15, *)
  func perform<R: Requestable, T>(_ request: R) -> Future<T, NetworkError> where R.ResponseType == T
  
  /// Performs the given `request` against the network asynchronously returning the result.
  ///   - Parameter request: The request to process.
  /// - Returns: A `Future` resolving with either the decoded value or a `NetworkError`.
  @available(iOS 13.0, macOS 10.15, *)
  func perform<R, T>(_ request: R) async throws -> T where R : Requestable, T == R.ResponseType
}

public extension NetworkProvider {
  var isLoggingEnabled: Bool {
    get {
      Log.isEnabled
    }
    set {
      newValue ? Log.enable() : Log.disable()
    }
  }
}
