//
//  MGENetwork
// 

import Foundation
import MGENetwork

enum Requests {
  /// Requests for a random fact about Chuck Norris.
  case randomFact
  
  private var baseUrl: String { "https://matchilling-chuck-norris-jokes-v1.p.rapidapi.com" }
  
  private var defaultHeader: HTTPHeader {
    [
      "x-rapidapi-key": "2255cfb0c7msha1adee03527a925p1d265ajsn9a58a3fe1293"
    ]
  }
  
  func make() -> NetworkRequest {
    switch self {
    case .randomFact:
      let endpoint = ConcreteEndpoint(urlString: "\(baseUrl)/jokes/random")
      return NetworkRequest(method: .get, endpoint: endpoint, header: defaultHeader)
    }
  }
}

