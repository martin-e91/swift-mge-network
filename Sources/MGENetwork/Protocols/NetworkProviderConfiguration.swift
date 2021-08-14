//
//  MGENetwork
// 

import Foundation
import MGELogger

public protocol NetworkProviderConfiguration {
  /// The configuration used by the logger.
  var loggerConfiguration: LoggerConfiguration { get }
  
  /// The `URLSession` used for network tasks.
  var session: URLSession { get }
}
