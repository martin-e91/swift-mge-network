//
//  MGENetwork
// 

import Foundation
import MGELogger

public protocol NetworkClientConfiguration {
  /// The configuration used by the logger.
  /// Default value is a `NetworkLoggerConfiguration()`.
  var loggerConfiguration: LoggerConfiguration { get }
  
  /// The `URLSession` used for network tasks.
  var session: URLSession { get }
}

// Default Implementation

public extension NetworkClientConfiguration {
  var loggerConfiguration: LoggerConfiguration {
    NetworkLoggerConfiguration()
  }
}

/// The configuration for the `NetworkClient` logger.
public struct NetworkLoggerConfiguration: LoggerConfiguration {
  public let destination: Logger.Log.Destination
  
  public let minimumLogLevel: Logger.Log.Level
  
  public let maxMessagesLength: UInt

  public let timestampFormatter: DateFormatter

  public let truncatingToken: String
  
  public init(
    destination: Logger.Log.Destination = .console,
    minimumLogLevel: Logger.Log.Level = .debug,
    maxMessagesLength: UInt = 20_000,
    timestampFormatter: DateFormatter = defaultTimestampFormatter,
    truncatingToken: String = "<..>"
  ) {
    self.destination = destination
    self.minimumLogLevel = minimumLogLevel
    self.maxMessagesLength = maxMessagesLength
    self.timestampFormatter = timestampFormatter
    self.truncatingToken = truncatingToken
  }
}

public extension NetworkLoggerConfiguration {
  /// The default time formatter for the logger.
  static let defaultTimestampFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.timeZone = .current
    formatter.dateFormat = "yy-MM-dd hh:mm:ssSSS"
    
    return formatter
  }()
}
