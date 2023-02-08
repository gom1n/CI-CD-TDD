//
//  ContentView.swift
//  TDD
//
//  Created by 소하 on 2023/02/06.
//

import SwiftUI

struct ContentView: View {
    @State private var inputResult:[String] = ["?","?","?"]
    @State private var showScore:[String] = ["?","?","?"]
    @State private var isOpen = false
    @State private var isCorrect = false
    @State private var isEnd = false
    @State private var selectNum = 0
    @State private var resultList:[ResultData] = [ResultData(id: String(0), inputData: "없음", resultData: "없음")]
    private var numList = [Int](0...9)
    private var columns:[GridItem] = Array(repeating: .init(), count: 2)
    private let bullAndCows = BullsandCows()
    
    var body: some View {
        VStack(alignment: .center) {
            // 입력
            HStack {
                ForEach(inputResult.indices, id: \.self) { index in
                    Button(inputResult[index]) {
                        selectNum = Int(index)
                        isOpen = true
                    }
                    .font(.system(size: 60, weight: .bold))
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .background(.black)
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 0, leading: 9, bottom: 0, trailing: 9))
                    .foregroundColor(isEnd ? .yellow : .white)
                    .sheet(isPresented: $isOpen, content: {
                        // 숫자 선택창
                        LazyVGrid(columns: columns) {
                            ForEach(numList, id: \.self) { num in
                                Button(String(num)) {
                                    inputResult[selectNum] = String(num)
                                    isOpen = false
                                }
                                .font(.system(size: 45, weight: .bold))
                                .foregroundColor(.black)
                                .padding(9)
                            }
                        }
                        .presentationDetents([.medium])
                    })
                }
            }
            .padding()
            // 확인 버튼
            Button(isEnd ? "새로운 게임" : "확인하기") {
                if isEnd {
                    resetGame()
                } else {
                    if inputResult.firstIndex(of: "?") == nil {
                        checkNum()
                    }
                    if resultList.count >= 10 {
                        openAnswer()
                    }
                }
            }
            .background(isEnd ? .blue : .red)
            .foregroundColor(.white)
            .buttonStyle(.bordered)
            .cornerRadius(10)
            .padding()
            // 스코어 출력
            HStack {
                ForEach(showScore, id: \.self) { result in
                    Text(result)
                        .foregroundColor(getColor(result))
                        .font(.system(size: 30, weight: .semibold))
                        .padding()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 18, trailing: 0))
            // 이전 결과 리스트
            List(resultList) { result in
                HStack {
                    Text(result.id)
                        .frame(width: 45)
                    Divider()
                    Spacer()
                    Text(result.inputData)
                    Spacer()
                    Divider()
                    Spacer()
                    Text(result.resultData)
                    Spacer()
                }
                .environment(\.defaultMinListHeaderHeight, 1)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.grouped)
        }
        .padding(EdgeInsets(top: 30, leading: 0, bottom: 18, trailing: 0))
    }
    
    // 텍스트 컬러
    func getColor(_ str:String) -> Color {
        switch str {
        case "S":
            return .red
        case "B":
            return .blue
        case "O":
            return .black
        default:
            return .black
        }
    }
    
    // 정답 체크
    func checkNum() {
        // 정답 확인
        bullAndCows.checkResult(inputResult)
        // 정답 출력
        showScore = bullAndCows.getScore()
        // 정답 기록 출력
        if resultList.first?.id == "0" {
            resultList.removeAll()
        }
        let score = bullAndCows.printScore()
        let newResult = ResultData(
            id: String(resultList.count+1),
            inputData: inputResult.joined(separator: " "),
            resultData: score)
        resultList.append(newResult)
        isCorrect = bullAndCows.isCorrect
        isEnd = isCorrect
    }
    
    // 정답 공개
    func openAnswer() {
        let answer = bullAndCows.getAnswer()
        isCorrect = bullAndCows.isCorrect
        inputResult = answer
        isEnd = true
    }
    
    // 게임 리셋
    func resetGame() {
        // 리셋
        inputResult = ["?","?","?"]
        showScore = ["?","?","?"]
        isOpen = false
        isCorrect = false
        isEnd = false
        selectNum = 0
        resultList = [ResultData(id: String(0), inputData: "없음", resultData: "없음")]
        // 정답 변경
        bullAndCows.makeAnswer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
