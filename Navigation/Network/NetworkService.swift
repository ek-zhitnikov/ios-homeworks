//
//  NetworkService.swift
//  Navigation
//
//  Created by Евгений Житников on 18.08.2023.
//

import Foundation

enum AppConfiguration {
    case people(String)
    case starships(String)
    case planets(String)
}


struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        switch configuration {
        case .people(let url),
             .starships(let url),
             .planets(let url):
            guard let url = URL(string: url) else {
                print("Invalid URL")
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                // c. Вывод описания ошибки при отключенном интернете
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                // при отключенном интернете код -1009
                
                // b. Вывод .allHeaderFields и .statusCode
                if let httpResponse = response as? HTTPURLResponse {
                    print("All Header Fields: \(httpResponse.allHeaderFields)")
                    print("Status Code: \(httpResponse.statusCode)")
                }
                // a. Вывод данных в виде строки
                if let data = data {
                    let str = String(data: data, encoding: .utf8)
                    print("Data: \(str ?? "No Data")")
                }
            }
            
            task.resume()
        }
    }
}


