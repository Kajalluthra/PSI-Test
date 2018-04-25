//
//  PSIModelTests.swift
//  PSITestTests
//
//  Created by Kajal on 25/4/2018.
//  Copyright © 2018 Kajal. All rights reserved.
//

import XCTest
@testable import PSITest

class PSIModelTests: XCTestCase {
    
    var psiModelTest: PSIModel!
    
    override func setUp() {
        super.setUp()
        self.psiModelTest = PSIModel(info: NSDictionary())
    }
    
    override func tearDown() {
        self.psiModelTest = nil
        super.tearDown()
    }
    
    
    func testModelIsNotNil() {
        XCTAssertNotNil(self.psiModelTest)
        XCTAssertNotNil(self.psiModelTest.name)
        XCTAssertNotNil(self.psiModelTest.lat)
        XCTAssertNotNil(self.psiModelTest.lng)
    }
    
}
