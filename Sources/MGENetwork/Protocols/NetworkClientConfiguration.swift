//
//  MGENetwork
// 

import Foundation
import MGELogger

public protocol NetworkClientConfiguration {
  /// The configuration used by the logger.
  /// Default value is `Logger.defaultConfiguration`.
  var loggerConfiguration: LoggerConfiguration { get }
  
  /// The `URLSession` used for network tasks.
  var session: URLSession { get }
}

public extension NetworkClientConfiguration {
  var loggerConfiguration: LoggerConfiguration {
    Logger.defaultConfiguration
  }
}
