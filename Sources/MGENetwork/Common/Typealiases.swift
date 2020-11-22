//
//  MGENetwork
// 

import Foundation

/// A completion to handle a result or an error.
public typealias Completion<T, E: Error> = (Result<T, E>) -> Void

/// A type for representing HTTP header fields.
public typealias HTTPHeader = [String: String]
