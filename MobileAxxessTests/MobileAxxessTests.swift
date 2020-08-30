//
//  MobileAxxessTests.swift
//  MobileAxxessTests
//
//  Created by Pratik Sodha on 30/08/20.
//  Copyright © 2020 Pratik Sodha. All rights reserved.
//

import XCTest
@testable import MobileAxxess

class MobileAxxessTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testModel() {
        let jsonString = """
        {
          "id": "2639",
          "type": "image",
          "date": "9/4/2015",
          "data": "https://placeimg.com/620/320/any"
        }
        """

        let data = Data(jsonString.utf8)
        let model = try! JSONDecoder().decode(RawDataDM.self, from: data)
        XCTAssert(model.id == "2639", "result must be 2639 [found \(model.id).]")
    }
    
    func testOptionalValueModel() {
        let jsonString = """
        {
          "id": "2639",
          "type": "image",
        }
        """

        let data = Data(jsonString.utf8)
        let model = try! JSONDecoder().decode(RawDataDM.self, from: data)
        XCTAssert(model.id == "2639", "result must be 2639 [found \(model.id).]")
    }
    
}
