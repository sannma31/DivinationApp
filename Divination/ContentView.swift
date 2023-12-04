//
//  ContentView.swift
//  Divination
//
//  Created by 笠井翔雲 on 2023/12/05.
//

import SwiftUI

struct YearMonthDay: Hashable {
    var year: Int
    var month: Int
    var day: Int
}

struct ContentView: View {
    @State private var name: String = "ゆめみん"
    @State private var birthday: YearMonthDay = YearMonthDay(year: 2000, month: 1, day: 27)
    @State private var bloodType: String = "ab"
    @State private var today: YearMonthDay = YearMonthDay(year: 2000, month: 1, day: 27)
    
    var body: some View {
        VStack(spacing: 20) {
            Text("名前を入力してね")
                .font(.headline)
            
            TextField("名前を入力してください", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
                .foregroundColor(.gray)
            
            Text("血液型を入力してください")
                .font(.headline)
            
            TextField("血液型を入力してください", text: $bloodType)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
                .foregroundColor(.gray)
        }
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
