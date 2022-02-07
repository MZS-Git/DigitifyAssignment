//
//  openWeatherApiTests.swift
//  openWeatherApiTests
//
//  Created by Muhammad Zain Shahid on 07/02/2022.
//

import XCTest
@testable import openWeatherApi

class openWeatherApiTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let jsonData = "[{\"t\"}]".data(using: .utf8)
        let apiParser = AppDataSerializer()
        var errorResponse: Error?
        let errorExpectation = expectation(description: "error")
        apiParser.parseData(data: jsonData!, ofType: WeatherResult.self) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let failure):
                errorResponse = failure
                errorExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(errorResponse)
          }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
