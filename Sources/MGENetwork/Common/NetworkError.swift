//
//  MGENetwork
//

import Foundation

/// Error occurring upon network tasks.
public enum NetworkError: Error {
  /// Occurs when 400 status code is received from the server.
  case badRequest
  
  /// An error occuring while performing encoding operations.
  case encodingFailure
  
  /// Error occuring when data is invalid.
  case invalidData

  /// Error occurring when trying to create an invalid `URL` instance.
  case invalidURL

  /// Occurs when 403 status code is received from the server.
  case forbidden
  
  /// A generic error.
  case generic(Error)
  
  /// Occurs when 404 status code is received from the server.
  case notFound

  /// Occurs when 401 status code is received from the server.
  case unauthorized
  
  /// Used when an unkown error occurs.
  case unknown
  
  /// A message for better understanding the error.
  public var message: String {
    switch self {
    case .badRequest:
      return "Request was invalid"
      
    case .encodingFailure:
      return "Encoding failed"
      
    case .forbidden:
      return "Received Forbidden statu code error from server"
      
    case .invalidData:
      return "Data is invalid"
      
    case .invalidURL:
      return "Given URL was invalid"
      
    case .generic(let error):
      return error.localizedDescription
    
    case .notFound:
      return "Received Not Found status code error from server"
      
    case .unauthorized:
      return "Received Unauthorized error from server"
      
    case .unknown:
      return "Something went wrong"
    }
  }
}
