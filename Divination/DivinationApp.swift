//
//  DivinationApp.swift
//  Divination
//
//  Created by 笠井翔雲 on 2023/12/05.
//
import SwiftUI
import Foundation

struct PrefectureInfo: Codable {
    let name: String
    let capital: String
    let citizenDay: YearMonthDay
    let hasCoastLine: Bool
    let logoURL: String
    let brief: String
}

struct DivinationApp: View {
    @Binding var name: String
    @Binding var birthday: YearMonthDay
    @Binding var bloodType: String
    @Binding var today: YearMonthDay
    @State   var text = ""
    @State   var Divinationname = ""
    @State   var Divinationcapital = ""
    @State   var logo = ""
    @State   var Divinationbrief = ""
    @State   var Divinationhas_coast_line : Int = 0
    
    var body: some View {
        
        let imageUrl = URL(string: logo)
        
        VStack {
            Image(decorative: "kamisama")
                        .resizable()
                        .scaledToFit()      // 縦横比を維持しながらフレームに収める
                        .frame(width: 300, height: 150)
            Text("診断結果じゃ")
                .font(.largeTitle)
                .foregroundColor(.purple)
                .padding()
            Text(text)
            Text(Divinationname)
                .padding(10)
            Text(Divinationcapital)
                .padding(10)
            Text(Divinationbrief)
                .padding(10)
            if Divinationhas_coast_line == 0{
                Text("海岸線あり！")
            }else{
                Text("海岸線はない")
            }
            AsyncImage(url: imageUrl) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 240, height: 126)
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
        //        open class func jsonObject(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> Any
        
        
        // URLSessionを使用してリクエストを送信
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // Convert the response data to a Foundation object
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    // Now you can work with the JSON object if needed
                    Divinationname = json["name"] as! String
                    Divinationcapital = json["capital"] as! String
                    logo = json["logo_url"] as! String
                    Divinationbrief = json["brief"] as! String
                    Divinationhas_coast_line = json["has_coast_line"] as! Int
                    print(json)
                    // Assuming there's a key named "fortune" in the JSON response
                    if let fortune = json["fortune"] as? String {
                        return fortune
                    }else {
                        return ""  // Handle the case when the "fortune" key is not present in the response
                    }
                } else {
                    return ""  // Handle the case when JSONSerialization.jsonObject throws an error or the conversion is not successful
                }
            } catch {
                print("Error converting response data to JSON: \(error)")
                return ""  // Handle the error appropriately
            }
        } catch {
            print("Error: \(error)")
            return ""  // Handle the error appropriately
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
