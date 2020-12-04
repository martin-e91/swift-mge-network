//
//  MGENetwork
// 

import Foundation
import MGELogger

/// The logger of the module.
#if DEBUG
let Log = Logger(logLevel: .debug)
#else
let Log = Logger()
#endif
