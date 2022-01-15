//
//  MGENetwork
//

import Foundation

/// An entity that can execute an `Operation`.
public protocol OperationExecutor {
  /// Executes an opetation.
  func execute(_ operation: Operation)
}
