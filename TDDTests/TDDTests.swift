//
//  TDDTests.swift
//  TDDTests
//
//  Created by 소하 on 2023/02/06.
//

import XCTest
@testable import TDD

final class TDDTests: XCTestCase {
    // 숫자야구 게임 작동을 위한 메인 클래스
    private var bullAndCows:BullsandCows!
    
    // 초기화 및 세팅
    override func setUpWithError() throws {
        try super.setUpWithError()
        bullAndCows = BullsandCows()
    }
    // CleanUp
    override func tearDownWithError() throws {
        bullAndCows = nil
        try super.tearDownWithError()
    }
    
    // BullsandCows 생성 시 초기 정답 값 여부 확인
    func testAnswerNotNil() {
        // given, when
        let answer = bullAndCows.getAnswer()
        // then
        XCTAssertNotEqual(answer.count, 0)
    }
    
    // SSS일 경우
    func testSSS() throws {
        // given, 값 설정
        bullAndCows.inputAnswer("123")
        bullAndCows.checkResult(["1", "2", "3"])
        // when, 테스트 코드 실행
        let result = bullAndCows.printScore()
        // then, 예상 결과 확인
        XCTAssertEqual(result, "S S S", "정답이 잘못되었습니다")
    }
    
    // OOO일 경우
    func testOOO() throws {
        // given, 값 설정
        bullAndCows.inputAnswer("000")
        bullAndCows.checkResult(["1", "2", "3"])
        // when, 테스트 코드 실행
        let result = bullAndCows.printScore()
        // then, 예상 결과 확인
        XCTAssertEqual(result, "O O O", "정답이 잘못되었습니다")
    }
    
    // BBB일 경우
    func testBBB() throws {
        // given, 값 설정
        bullAndCows.inputAnswer("312")
        bullAndCows.checkResult(["1", "2", "3"])
        // when, 테스트 코드 실행
        let result = bullAndCows.printScore()
        // then, 예상 결과 확인
        XCTAssertEqual(result, "B B B", "정답이 잘못되었습니다")
    }
    
    // SOS일 경우
    func testSOS() throws {
        // given, 값 설정
        bullAndCows.inputAnswer("103")
        bullAndCows.checkResult(["1", "2", "3"])
        // when, 테스트 코드 실행
        let result = bullAndCows.printScore()
        // then, 예상 결과 확인
        XCTAssertEqual(result, "S O S", "정답이 잘못되었습니다")
    }

    // 성능 체크용
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
