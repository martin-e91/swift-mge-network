//
//  MGENetwork
// 

import Foundation

struct ChuckNorrisFact: Decodable {
  enum CodingKeys: String, CodingKey {
    case iconUrl = "icon_url"
    case text = "value"
  }
  
  let iconUrl: String
  
  let text: String
}
