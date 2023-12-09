//
//  ContentView.swift
//  Divination
//
//  Created by 笠井翔雲 on 2023/12/05.
//
import SwiftUI

struct YearMonthDay: Hashable,Codable {
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
        NavigationView{
            VStack(spacing: 10) {
                Text("相性の良い都道府県は")
                    .font(.largeTitle)
                    .foregroundColor(.purple)
                    .padding(10)
                Text("名前を入力してください")
                    .font(.headline)
                    .padding(10)
                
                TextField("名前を入力してください", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(5)
                    .frame(width: 200, height: 50)
                    .foregroundColor(Color("ThemaColor"))
                
                Text("誕生日を入力してください")
                    .font(.headline)
                
                
                DatePicker("", selection: $birthday.date, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding(10)
                    .foregroundColor(Color("ThemaColor"))
                    .accentColor(.blue)
                
                
                Text("血液型を入力してください")
                    .font(.headline)
                
                TextField("血液型を入力してください", text: $bloodType)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200, height: 50)
                    .padding(5)
                    .foregroundColor(Color("ThemaColor"))
                    .padding()
                    .onAppear {
                        // 今日の日付を取得して設定
                        let todayDate = Date()
                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.year, .month, .day], from: todayDate)
                        today.year = components.year ?? 0
                        today.month = components.month ?? 0
                        today.day = components.day ?? 0
                        
                    }
                    .padding()
                NavigationLink(
                    destination: DivinationApp(name: $name, birthday: $birthday, bloodType: $bloodType, today: $today)){
                        Text("診断")
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.purple)
                            .foregroundColor(Color("ThemaColor"))
                            .cornerRadius(10)
                        
                    }
                
            }
            .buttonStyle(BorderlessButtonStyle())
            
            Spacer()
        }
        //        .environment(\.colorScheme, .dark)
    }
    
}

extension YearMonthDay {
    var date: Date {
        get {
            return Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
        }
        set {
            let components = Calendar.current.dateComponents([.year, .month, .day], from: newValue)
            year = components.year ?? 0
            month = components.month ?? 0
            day = components.day ?? 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
