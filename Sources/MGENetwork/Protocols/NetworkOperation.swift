//
//  MGENetwork
//

import Foundation

/// An `Operation` performing network tasks.
public protocol NetworkOperation: Operation {
  associatedtype ResponseType
  associatedtype E: Error
  associatedtype RequestType: Requestable where RequestType.ResponseType == ResponseType

  /// The block to execute when the operation finishes.
  var completion: Completion<ResponseType, E>? { get }
  
  init(session: URLSession, request: RequestType)

  /// Runs the operation.
  func execute()
}
