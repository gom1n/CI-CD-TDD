//
//  TDDUITests.swift
//  TDDUITests
//
//  Created by 소하 on 2023/02/06.
//

import XCTest

final class TDDUITests: XCTestCase {
    // Test UIApplication
    let app = XCUIApplication()
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    // 숫자 입력을 위해 버튼을 클릭했을때 시트가 등장하여 숫자 버튼이 노출되는가
    func testClickNumButtonAndUpSheet() throws {
        // 테스트 앱 실행
        let app = XCUIApplication()
        app.launch()
        // Num 버튼을 찾고 존재하는지 확인
        let btnInput = app.buttons.firstMatch
        XCTAssertTrue(btnInput.exists)
        btnInput.tap() // 버튼 클릭
        // sheet가 열린 후 숫자 버튼들이 나오는지 확인
        let btnNum = app.buttons["0"]
        XCTAssertTrue(btnNum.exists, "숫자 버튼이 존재하지 않습니다")
    }
    
    // 숫자 입력 후 화면이 변경되는가
    func testClickSheetAfterChange() throws {
        // 테스트 앱 실행
        let app = XCUIApplication()
        app.launch()
        // Num 버튼을 찾고 존재하는지 확인
        let btnInput = app.buttons.firstMatch
        XCTAssertTrue(btnInput.exists)
        btnInput.tap() // 버튼 클릭
        // sheet가 열린 후 숫자 버튼들이 나오는지 확인
        let btnZero = app.buttons["0"]
        XCTAssertTrue(btnZero.exists, "숫자 버튼이 존재하지 않습니다")
        btnZero.tap() // sheet에서 숫자 클릭
        // 화면이 변경되었는지 확인
        let btnMark = app.buttons["?"]
        XCTAssertNotEqual(btnInput, btnMark, "?가 숫자로 변경되지 않았습니다")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
