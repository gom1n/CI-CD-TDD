//
//  TDDUITests.swift
//  TDDUITests
//
//  Created by 소하 on 2023/02/06.
//

import XCTest

final class TDDUITests: XCTestCase {
    // 초기화 및 세팅
    override func setUpWithError() throws {
        try super.setUpWithError()
        // 테스트 실패 발생 시, 계속하여 실행할지
        continueAfterFailure = false
    }
    // CleanUp
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
        // sheet가 열려서 숫자 버튼들이 나오는지 확인
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
        // sheet가 열려서 숫자 버튼들이 나오는지 확인
        let btnZero = app.buttons["0"]
        XCTAssertTrue(btnZero.exists, "숫자 버튼이 존재하지 않습니다")
        btnZero.tap() // sheet에서 숫자 클릭
        // 화면이 변경되었는지 확인
        let btnMark = app.buttons["?"]
        XCTAssertNotEqual(btnInput, btnMark, "?가 숫자로 변경되지 않았습니다")
    }
    
    // 숫자 입력 후 중복된 숫자이면 Alert을 띄우는가
    func testClickSheetAfterCheckOverlap() throws {
        // 테스트 앱 실행
        let app = XCUIApplication()
        app.launch()
        // 숫자 입력 버튼 탭
        let btnInput0 = app.buttons.element(boundBy: 0)
        XCTAssertTrue(btnInput0.exists)
        btnInput0.tap()
         
        // sheet가 열려서 숫자 버튼들이 나오는지 확인
        let btnZero0 = app.buttons["keypad0"]
        XCTAssertTrue(btnZero0.exists, "숫자 버튼이 존재하지 않습니다")
        btnZero0.tap() // sheet에서 숫자 0 클릭
           
        // 숫자 입력 버튼 탭
        let btnInput1 = app.buttons.element(boundBy: 1)
        XCTAssertTrue(btnInput1.exists)
        btnInput1.tap()
             
        // sheet가 열려서 숫자 버튼들이 나오는지 확인
        let btnZero1 = app.buttons["keypad0"]
        XCTAssertTrue(btnZero1.exists, "숫자 버튼이 존재하지 않습니다")
        btnZero1.tap() // sheet에서 숫자 0 클릭
             
        // 중복된 숫자인 경우 Alert 표시 확인
        XCTAssertTrue(app.alerts["알림"].exists)
            
        // 확인 버튼 탭하여 Alert 닫기
        app.alerts.buttons["확인"].tap()
    }
    
    // 성능 체크용
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
