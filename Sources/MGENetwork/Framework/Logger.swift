//
//  Logger.swift
//

import Foundation

#warning("Add file logging")

/// Syntactic sugar for a logger message.
typealias Message = String

/// A logger for console logging.
public final class Logger {
  /// Whether the logger is enabled or not.
  var isEnabled: Bool = true
  
  /// The token appended at the end of a truncated string.
  static let truncatingToken = "<..>"
  
  // MARK: - Stored Properties
  
  /// The level for messages of this logger. Default level is `info`.
  let logLevel: LogLevel
  
  /// The max characters length of a log message. Any message longer than this value will be truncated.
  /// Default value is `20_000`.
  let maxMessagesLength: Int
  
  /// A `DateFormatter` for the timestamp in the log messages.
  private let timestampFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.timeZone = .current
    formatter.dateFormat = "yy-MM-dd hh:mm:ssSSS"
    return formatter
  }()
  
  // MARK: - Init
  
  #warning("Change default log level to .info")
  internal init(logLevel: LogLevel = .info, maxMessagesLength: Int = 20_000) {
    self.logLevel = logLevel
    self.maxMessagesLength = maxMessagesLength
  }
}

// MARK: - Helpers

extension Logger {
  func debug(
    title: String,
    message: Message,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
  ) {
    log(title: title, message: message, for: .debug, file: file, line: line, function: function)
  }
}

// MARK: - Private Helpers

private extension Logger {
  private func log(
    title: String,
    message: Message,
    for level: LogLevel,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
  ) {
    guard
      isEnabled,
      level.rawValue >= self.logLevel.rawValue
    else {
      return
    }
    
    let formattedMessage = format(title: title, message: message, for: level, file: file, line: line, function: function)
    
    print(formattedMessage)
  }

  /// Formats this message.
  /// - Parameter message: message to be formatter.
  /// - Returns: a new formatted message.
  private func format(
    title: String,
    message: Message,
    for level: LogLevel,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
  ) -> Message {
    let timestamp = timestampFormatter.string(from: Date())
      
    let fileName = self.fileName(from: file)

    let formattedMessage =
      """

      ========
      [\(timestamp)] \(level.token): \(fileName):\(line): \(function):
      \(title)

      \(message)

      ========

      """
    
    return truncatedMessageIfNeeded(formattedMessage)
  }
  
  private func fileName(from filePath: String) -> String {
    return filePath.components(separatedBy: "/").last ?? "nil_file_name"
  }
  
  /// Truncates the given message if needed.
  /// - Parameter message: message to be trunked.
  /// - Returns: a `Message` truncated if longer than `maxMessagesLength`.
  private func truncatedMessageIfNeeded(_ message: Message) -> Message {
    return message.count >= maxMessagesLength ?
      message.prefix(maxMessagesLength).appending(Logger.truncatingToken) : message
  }
}
