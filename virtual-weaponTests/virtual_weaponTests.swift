//
//  virtual_weaponTests.swift
//  virtual-weaponTests
//
//  Created by Ming Sun on 4/8/21.
//

import XCTest
@testable import virtual_weapon

class virtual_weaponTests: XCTestCase {
    var llq = LimitedLengthQueue<Int>(length: 4)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLimitedLengthQueue() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var testingList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
        llq.push(item: testingList.removeFirst())
        llq.push(item: testingList.removeFirst())
        llq.push(item: testingList.removeFirst())
        llq.push(item: testingList.removeFirst())
        XCTAssertTrue(llq.view() == [1,2,3,4])
        llq.push(item: testingList.removeFirst())
        llq.push(item: testingList.removeFirst())
        XCTAssertTrue(llq.view() == [3,4,5,6])
        llq.length = 8
        llq.push(item: testingList.removeFirst())
        llq.push(item: testingList.removeFirst())
        print(llq.view())
        XCTAssertTrue(llq.view() == [3,4,5,6,7,8])
    }
}
