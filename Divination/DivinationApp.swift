//
//  DivinationApp.swift
//  Divination
//
//  Created by 笠井翔雲 on 2023/12/05.
//

import SwiftUI


struct DivinationApp: View {
    @Binding var name: String
    @Binding var birthday: YearMonthDay
    @Binding var bloodType: String
    @Binding var today: YearMonthDay
    
    init(name: Binding<String>, birthday: Binding<YearMonthDay>, bloodType: Binding<String>, today: Binding<YearMonthDay>) {
        _name = name
        _birthday = birthday
        _bloodType = bloodType
        _today = today
    }
    
    var body: some View {
        VStack {
            Text("診断結果じゃ")
                .font(.title)
                .padding()
            
            // Add your divination results here based on the provided inputs
            Text("名前: \(name)")
            Text("誕生日: \(birthday.year)/\(birthday.month)/\(birthday.day)")
            Text("血液型: \(bloodType)")
            Text("日付: \(today.year)/\(today.month)/\(today.day)")
            
            // Add more divination results as needed
            
            Spacer()
        }
        .padding()
    }
}

@main
struct Divinationapp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



