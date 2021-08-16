//
//  MGENetwork
// 

import Foundation

/// A completion to handle a result or an error.
public typealias Completion<T, E: Error> = (Result<T, E>) -> Void

/// Represents the path of an URL string.
public typealias Path = [String]

/// A type for representing HTTP header fields.
public typealias HTTPHeaders = [String: String]
