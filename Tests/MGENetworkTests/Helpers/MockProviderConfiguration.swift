//
//  MGENetwork
// 

import Foundation
import MGELogger

@testable import MGENetwork

/// The mock  network provider configuration user for unit tests.
struct MockNetworkProviderConfiguration: NetworkClientConfiguration {  
  let session: URLSession = URLSession(configuration: .default)
  let loggerConfiguration: LoggerConfiguration = MockLoggerConfiguration()
}

/// The mock logger configuration user for unit tests.
struct MockLoggerConfiguration: LoggerConfiguration {
  let destination: Logger.Log.Destination = .console
  let maxMessagesLength: UInt = 1000
  let minimumLogLevel: Logger.Log.Level = .info
  let timestampFormatter: DateFormatter = DateFormatter()
  let truncatingToken: String = ""
}
