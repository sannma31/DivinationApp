//
//  ApiConstants.swift
//  Divination
//
//  Created by 笠井翔雲 on 2023/12/06.
//

import SwiftUI
import Foundation

struct ApiConstants {
    static func performDivination(requestData: DivinationApp, completion: @escaping (DivinationResult) -> Void) {
        let baseURL = "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud"
        let endpoint = "/my_fortune"

        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("v1", forHTTPHeaderField: "API-Version")

        do {
            let encoder = JSONEncoder()
//            request.httpBody = try encoder.encode(requestData)
        } catch {
            print("Error encoding request data: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
//                print("Error fetching data: \(error ?? "Unknown error")")
                return
            }

            do {
                let decoder = JSONDecoder()
//                let result = try decoder.decode(DivinationResult.self, from: data)
                DispatchQueue.main.async {
//                    completion(result)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
