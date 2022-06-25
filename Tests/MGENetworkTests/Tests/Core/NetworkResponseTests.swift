//
//  MGENetwork
// 

import XCTest

@testable import MGENetwork

class NetworkResponseTests: XCTestCase {
	func testInit_setsPropertiesCorrectly() {
		let expectedURLRequest = URLRequest(url: URL(fileURLWithPath: "/"))
		let expectedHTTPResponse = HTTPURLResponse()
		let sut = NetworkResponse<String>(body: "hello", request: expectedURLRequest, httpResponse: expectedHTTPResponse)
		XCTAssertEqual(sut.body, "hello")
		XCTAssertEqual(sut.request, expectedURLRequest)
		XCTAssertEqual(sut.httpResponse, expectedHTTPResponse)
	}
	
	func testDescription_isGeneratedCorrectly() throws {
		struct Mock: Decodable {
			let text: String
		}
		let sut = NetworkResponse<Mock>(
			body: Mock(text: "prova"),
			request: URLRequest(url: URL(string: "https://wwww.api.com/bro/test")!),
			httpResponse: HTTPURLResponse(url: URL(string: "https://wwww.api.com/bro/test")!, statusCode: 200, httpVersion: "1.1", headerFields: ["test": "value"])!
		).description

		XCTAssertEqual(
			sut,
"""
GET https://wwww.api.com/bro/test
HTTP status: 200
Decoded object:
Mock(text: "prova")
"""
		)
	}
}
