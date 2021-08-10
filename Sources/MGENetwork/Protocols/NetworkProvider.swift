//
//  MGENetwork
//

import Foundation
import Combine

#warning("Logger configuration can be exposed as a protocol")

/// An entity providing ways of making requests against the network.
public protocol NetworkProvider {
  /// Whether the logging is enabled or not. Default value is `true`.
  var isLoggingEnabled: Bool { get set }
  
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
  @available(iOS 13.0, *)
  @discardableResult
  func perform<R: Requestable, T>(_ request: R) -> Future<T, NetworkError> where R.ResponseType == T
  
  /// Downloads raw data from the given url.
  /// - Parameters:
  ///   - urlString: The endpoint for the network task.
  ///   - completion: Completion block for handling result.
  @discardableResult
  func download(from urlString: String, completion: @escaping Completion<Data, NetworkError>) -> Operation
}

public extension NetworkProvider {
  var isLoggingEnabled: Bool {
    get {
      Log.isEnabled
    }
    set {
      Log.isEnabled = newValue
    }
  }
}
