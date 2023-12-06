//
//  DivinationApp.swift
//  Divination
//
//  Created by 笠井翔雲 on 2023/12/05.
//
import SwiftUI
import Foundation



struct DivinationApp: View {
    @Binding var name: String
    @Binding var birthday: YearMonthDay
    @Binding var bloodType: String
    @Binding var today: YearMonthDay
    @State   var text = ""
    var body: some View {
        VStack {
            Text("診断結果じゃ")
                .font(.title)
                .padding()
            Text(text)
        }
        .task{
            let text = await getFortune()
            self.text = text
        }
        .padding()
    }
    func getFortune() async -> String {
        // APIのエンドポイント
        let url = URL(string: "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud/my_fortune")!
        
        // リクエストデータ
        let requestData: [String: Any] = [
            "name": name,
            "birthday": [
                "year": birthday.year,
                "month": birthday.month,
                "day": birthday.day
            ],
            "blood_type": bloodType.lowercased(),
            "today": [
                "year": today.year,
                "month": today.month,
                "day": today.day
            ]
        ]
        
        // ヘッダー
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("v1", forHTTPHeaderField: "API-Version")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // リクエストデータをJSONに変換
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData)
            request.httpBody = jsonData
        } catch {
            print("Error creating JSON data: \(error)")
            return ""  // エラーが発生した場合、空の文字列を返すか適切なエラー処理を行う
        }
        
        // URLSessionを使用してリクエストを送信
        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            // レスポンスデータを文字列に変換して返す
            if let resultString = String(data: data, encoding: .utf8) {
                return resultString
            } else {
                return ""  // 文字列に変換できない場合、空の文字列を返すか適切なエラー処理を行う
            }
        } catch {
            print("Error: \(error)")
            return ""  // エラーが発生した場合、空の文字列を返すか適切なエラー処理を行う
        }
    }

    
}

@main
struct DivinationAppMain: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
