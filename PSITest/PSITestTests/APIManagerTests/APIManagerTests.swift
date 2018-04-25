//
//  APIManagerTests.swift
//  PSITestTests
//
//  Created by Kajal on 25/4/2018.
//  Copyright © 2018 Kajal. All rights reserved.
//

import XCTest
@testable import PSITest

class APIManagerTests: XCTestCase {
    var apiManager = APIManager.shared()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchPSI() {
        
        let expect = XCTestExpectation(description: "trigger")
        
        apiManager.getPSIData(){(success, response, error) in
            if success {
                expect.fulfill()
                XCTAssertNotNil(response)
                
            } else {
                 XCTFail()
            }
        }
        
        wait(for: [expect], timeout: 5.0)
    }
}
