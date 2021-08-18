//
//  MGENetwork
// 

import Foundation
import MGELogger
import MGENetwork

/// The `NetworkClient` instance used for unit testing the module.
let mockNetworkClient: NetworkClient = {
  var client = NetworkClient(with: MockNetworkProviderConfiguration())
  client.isLoggingEnabled = false
  return client
}()

/// The mock  network provider configuration user for unit tests.
struct MockNetworkProviderConfiguration: NetworkClientConfiguration {  
  let session: URLSession = {
    let mockConfiguration = URLSessionConfiguration.default
    mockConfiguration.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: mockConfiguration)
  }()
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
