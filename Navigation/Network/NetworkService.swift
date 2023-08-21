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

enum NetworkError: Error {
    case statusCodeNot200
    case dataIsNil
    case answerNotCast
    case keyNotFound
    
}

struct PlanetDetails: Codable {
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}

struct NetworkService {
    
    //Задание 2_2
    static func downloadOrbitalPeriod(completion: @escaping (Result<String, Error>) -> Void ) {
        let url = URL(string: "https://swapi.dev/api/planets/1")!
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                print("StatusCode != 200")
                completion(.failure(NetworkError.statusCodeNot200))
                return
            }
            
            guard let data else {
                print("Data is nil")
                completion(.failure(NetworkError.dataIsNil))
                return
            }
            
            do {
                let planetDetails = try JSONDecoder().decode(PlanetDetails.self, from: data)
                completion(.success(planetDetails.orbitalPeriod))
                
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
    
    //Задание 2_1
    static func downloadTitle(completion: @escaping (Result<String, Error>) -> Void ) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                print("StatusCode != 200")
                completion(.failure(NetworkError.statusCodeNot200))
                return
            }
            
            guard let data else {
                print("Data is nil")
                completion(.failure(NetworkError.dataIsNil))
                return
            }
            
            do {
                guard let answer = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    print("answer not cast to [String: Any]")
                    completion(.failure(NetworkError.answerNotCast))
                    return
                }
                
                guard let title = answer["title"] as? String else {
                    print("Key title not found")
                    completion(.failure(NetworkError.keyNotFound))
                    return
                }
                completion(.success(title))
                
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
    
    //Задание 1
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


