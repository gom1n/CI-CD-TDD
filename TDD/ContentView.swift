//
//  ContentView.swift
//  TDD
//
//  Created by 소하 on 2023/02/06.
//

import SwiftUI

struct ContentView: View {
    @State private var answer = ""
    @State private var printResult:[String] = ["?","?","?"]
    @State private var isOpen = false
    @State private var inputResult:[String] = ["?","?","?"]
    @State private var selectNum = 0
    @State private var resultList:[ResultData] = [ResultData(id: String(0), inputData: "없음", resultData: "없음")]
    private var numList = [Int](0...9)
    private var columns:[GridItem] = Array(repeating: .init(), count: 2)
    
    var body: some View {
        VStack(alignment: .center) {
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
                    .foregroundColor(.white)
                    .sheet(isPresented: $isOpen, content: {
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
            
            Button("확인하기") {
                if inputResult.firstIndex(of: "?") == nil {                
                    checkNum()
                }
            }
            .background(.red)
            .foregroundColor(.white)
            .buttonStyle(.bordered)
            .cornerRadius(10)
            .padding()

            
            HStack {
                ForEach(printResult, id: \.self) { result in
                    Text(result)
                        .font(.system(size: 30, weight: .semibold))
                        .padding()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
            
            List(resultList) { result in
                HStack {
                    Text(result.id)
                        .frame(width: 45, alignment: .center)
                    Divider()
                    HStack {
                        Spacer()
                        Text(result.inputData)
                        Spacer()
                        Divider()
                        Spacer()
                        Text(result.resultData)
                        Spacer()
                    }
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.inset)
        }
        .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
    }
    
    // 정답 체크
    func checkNum() {
        printResult = ["O", "O", "O"]
        if resultList.count == 1 {
            resultList.removeAll()
        }
        resultList = [ResultData(
            id: String(resultList.count+1),
            inputData: inputResult.joined(separator: " "),
            resultData: printResult.joined(separator: " "))]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
