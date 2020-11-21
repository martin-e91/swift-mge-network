//
//  File.swift
//

import Foundation

public extension Data {
  /// Returns the `JSON` string representation of this Data instance.
  var prettyPrintedJSON: String? {
    guard
      let jsonObject = try? JSONSerialization.jsonObject(with: self),
      let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
      let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
    else {
      return nil
    }
    
    return String(string)
  }
}
