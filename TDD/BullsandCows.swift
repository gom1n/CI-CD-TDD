//
//  BullsandCows.swift
//  TDD
//
//  Created by 소하 on 2023/02/08.
//

import Foundation

class BullsandCows {
    private var answer:[String] = []
    private var score:[String] = []
    // 정답 여부
    var isCorrect:Bool {
        return score == ["S", "S", "S"]
    }
    
    init() {
        makeAnswer()
    }
    
    // 정답 입력
    func inputAnswer(_ input:String) {
        // 정답 리셋
        answer.removeAll()
        // 입력 값으로 정답 설정
        _ = input.map{ answer.append(String($0)) }
    }
    
    // 정답 생성기
    func makeAnswer() {
        // 정답 리셋
        answer.removeAll()
        // 랜덤한 정답 생성
        for _ in 0..<3 {
            let randomNum = Int.random(in: 0...9)
            answer.append(String(randomNum))
        }
    }
    
    // 정답 확인
    func checkResult(_ input:[String]) {
        // score 비우기
        score.removeAll()
        // 정답 체크
        for (i, data) in input.enumerated() {
            for (j, result) in answer.enumerated() {
                if data == result {
                    score.append(i == j ? "S" : "B")
                    break
                }
            }
            if score.count-1 != i {
                score.append("O")
            }
        }
    }
    
    // 정답 반환
    func getAnswer() -> [String] {
        return answer
    }
    
    // 스코어 반환
    func getScore() -> [String] {
        return score
    }
    
    // 스코어 출력
    func printScore() -> String {
        let result = score.joined(separator: " ")
        return result
    }
}
