//
//  MGENetwork
//

import Foundation

/// Error occurring upon network tasks.
public enum NetworkError: Error {
  /// Error occurring when trying to create an invalid `URL` instance.
  case invalidURL
  
  /// Error occuring when data is invalid.
  case invalidData
  
  /// A generic error.
  case generic(Error)
}
