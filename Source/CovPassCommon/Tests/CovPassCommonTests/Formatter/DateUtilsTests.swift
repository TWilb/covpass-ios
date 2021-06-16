//
//  DateUtilsTests.swift
//
//
//  © Copyright IBM Deutschland GmbH 2021
//  SPDX-License-Identifier: Apache-2.0
//

import Foundation
import XCTest

@testable import CovPassCommon

class DateUtilsTests: XCTestCase {
    var date: Date!

    override func setUp() {
        super.setUp()
        date = Date(timeIntervalSince1970: 1000)
    }

    override func tearDown() {
        date = nil
        super.tearDown()
    }

    func testIsoDateFormatter() {
        XCTAssertEqual(DateUtils.isoDateFormatter.string(from: date), "1970-01-01")
    }

    func testIsoDateTimeFormatter() {
        XCTAssertEqual(DateUtils.isoDateTimeFormatter.string(from: date), "1970-01-01T01:16:40+0100")
    }

    func testDisplayIsoDateFormatter() {
        XCTAssertEqual(DateUtils.displayIsoDateTimeFormatter.string(from: date), "1970-01-01 01:16")
    }

    func testDisplayTimeZoneFormatter() {
        XCTAssertEqual(DateUtils.displayTimeZoneFormatter.string(from: date), "GMT+01:00")
    }

    func testDisplayDateFormatter() {
        XCTAssertEqual(DateUtils.displayDateFormatter.string(from: date), "1/1/70")
    }

    func testDisplayDateTimeFormatter() {
        XCTAssertEqual(DateUtils.displayDateTimeFormatter.string(from: date), "1/1/70, 1:16 AM")
    }
}