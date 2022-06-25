//
//  MGENetwork
// 

import XCTest

@testable import MGENetwork

class NetworkResponseTests: XCTestCase {
	func testDescription_isGeneratedCorrectly() throws {
		struct Mock: Decodable {
			let text: String
		}
		let sut = NetworkResponse<Mock>(
			body: Mock(text: "prova"),
			request: URLRequest(url: URL(string: "https://wwww.api.com/bro/test")!),
			httpResponse: HTTPURLResponse(url: URL(string: "https://wwww.api.com/bro/test")!, statusCode: 123, httpVersion: "1.1", headerFields: ["test": "value"])!,
			executionTime: 7
		).description

		XCTAssertEqual(
			sut,
"""
GET https://wwww.api.com/bro/test
BODY:
Mock(text: "prova")
"""
		)
	}
}
