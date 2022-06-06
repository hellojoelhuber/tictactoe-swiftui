//
//  PlayerRequest.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/3/22.
//

import Foundation
import TicTacToeCore

struct PlayerRequest {
    let baseURL = "http://127.0.0.1:8080/api/users/"
    let httpMethod: String
    let resourceURL: URL

    init(httpMethod: String, resourcePath: String) {
        self.httpMethod = httpMethod
        guard let resourceURL = URL(string: baseURL) else {
            fatalError("Failed to convert baseURL to a URL")
        }
        self.resourceURL = resourceURL.appendingPathComponent(resourcePath)
    }
    
    private func createURLRequest(url: URL, token: String) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return urlRequest
    }
    
    func getPlayerInfo(auth: Auth,
                    completion: @escaping (Result<PlayerProfileDTO, ResourceRequestError>) -> Void) {
        guard let token = auth.token else {
            auth.logout()
            return
        }
        let urlRequest = createURLRequest(url: resourceURL, token: token)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let resources = try JSONDecoder().decode(PlayerProfileDTO.self, from: jsonData)
                completion(.success(resources))
            } catch {
                print(error)
                completion(.failure(.decodingError))
            }
        }
        dataTask.resume()
    }
//
//    func createPlayer(_ gameSettings: GameSettings,
//                          auth: Auth,
//                    completion: @escaping (Result<Game.Public, ResourceRequestError>) -> Void) {
//        do {
//            guard let token = auth.token else {
//                auth.logout()
//                return
//            }
//            var urlRequest = createURLRequest(url: resourceURL, token: token)
//            urlRequest.httpBody = try JSONEncoder().encode(gameSettings)
//
//            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    completion(.failure(.noData))
//                    return
//                }
//                guard httpResponse.statusCode == 200, let jsonData = data else {
//                    if httpResponse.statusCode == 401 {
//                        auth.logout()
//                    }
//                    completion(.failure(.noData))
//                    return
//                }
//
//                do {
//                    let resource = try JSONDecoder().decode(Game.Public.self, from: jsonData)
//                    completion(.success(resource))
//                } catch {
//                    completion(.failure(.decodingError))
//                }
//            }
//            dataTask.resume()
//        } catch {
//            completion(.failure(.encodingError))
//        }
//    }
//
//    func getFollowingPlayers(since turn: Int,
//                    auth: Auth,
//                    completion: @escaping (Result<[GameAction], ResourceRequestError>) -> Void) {
//        guard let token = auth.token else {
//            auth.logout()
//            return
//        }
//        let urlRequest = createURLRequest(url: URL(string: "\(resourceURL)\(turn)")!, token: token)
//
//        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(.noData))
//                return
//            }
//            guard httpResponse.statusCode != 202 else {
//                let resources: [GameAction] = []
//                completion(.success(resources))
//                return
//            }
//
//            guard let jsonData = data else {
//                completion(.failure(.noData))
//                return
//            }
//
//            do {
//                let resources = try JSONDecoder().decode([GameAction].self, from: jsonData)
//                completion(.success(resources))
//            } catch {
//                print(error)
//                completion(.failure(.decodingError))
//            }
//        }
//        dataTask.resume()
//    }
}
