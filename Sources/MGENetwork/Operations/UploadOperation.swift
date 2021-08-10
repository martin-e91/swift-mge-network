//
//  MGENetwork
// 

import Foundation

/// The `CompletionOperation` implementation for executing upload tasks.
public final class UploadOperation: CompletionOperation<Data, NetworkError> {
  
  /// The session used by this operation.
  private let session: URLSession
  
  /// Creates a new `UploadOperation` with the given session.
  /// - Parameters:
  ///   - session: The session instance to be used by this operation.
  ///   - request: The request to be performed.
  public init(session: URLSession, uploadRequest: UploadRequest) {
    self.session = session
  }
}
