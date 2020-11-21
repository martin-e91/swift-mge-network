//
//  Logger.swift
//

import Foundation

/// The logger for this module.
internal enum Logger {
  /// Whether the logger is enabled or not.
  static var isActive: Bool = true
  
  /// Logs the given message.
  /// - Parameter message: a message to be logged.
  static func log(
    title: String,
    message: Any?,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    print(
      """
      ===============
      File: \(file)
      Line: \(line)
      \(title)

      \(message ?? "nil")
      ===============
      
      """
    )
  }
}
