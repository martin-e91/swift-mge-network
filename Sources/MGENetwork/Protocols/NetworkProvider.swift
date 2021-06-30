//
//  MGENetwork
//

import Foundation

#warning("Logger configuration can be exposed as a protocol")

/// An entity providing ways of making requests against the network.
public protocol NetworkProvider {
  /// Whether the logging is enabled or not. Default value is `true`.
  var isLoggingEnabled: Bool { get set }
  
  /// Performs a request against the network.
  /// - Parameters:
  ///   - request: The request to process.
  ///   - completion: Completion block for handling result.
  @discardableResult
  func perform<R, T>(_ request: R, completion: @escaping Completion<T, NetworkError>) -> Operation where R: Requestable, R.ResponseType == T
  
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
