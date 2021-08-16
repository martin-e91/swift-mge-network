//
//  MGENetwork
// 

import Foundation

extension Dictionary {
  /// Wraps the dictionary into an `NSDictionary`.
  var nsDictionary: NSDictionary {
    NSDictionary(dictionary: self)
  }
}
