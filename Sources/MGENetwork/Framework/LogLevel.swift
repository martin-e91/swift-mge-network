//
//  MGENetwork
// 

import Foundation

/// Syntactic sugar for severity of the log levels.
internal typealias Severity = Int

/// Log level for the `Logger` used to determinate what to omit from logging output.
internal enum LogLevel: Severity {
  /// Messages that contains information only when debugging a program.
  case trace
  
  /// Messages that contain information normally of use only when debugging a program.
  case debug
  
  /// Informational messages.
  case info
  
  /// Messages that require attention.
  case warning
  
  /// Messages for error conditions.
  case error
  
  /// A token string associated with this log level.
  var token: String {
    switch self {
    case .trace:
      return "🤔 TRACE"
      
    case .debug:
      return "🐞 DEBUG"
      
    case .info:
      return "ℹ️ INFO"

    case .warning:
      return "⚠️ WARNING"
      
    case .error:
      return "⛔️ ERROR"
    }
  }
}
