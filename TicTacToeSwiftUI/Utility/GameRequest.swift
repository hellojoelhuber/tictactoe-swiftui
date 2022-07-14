
import Foundation
import TicTacToeCore

struct GameRequest {
    let baseURL = "http://127.0.0.1:8080/api/game/"
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
    
    func getGames(auth: Auth,
                  completion: @escaping (Result<[GameDTO], ResourceRequestError>) -> Void) {
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
                let decoder = JSONDateTimeDecoder()
                let resources = try decoder.decode([GameDTO].self, from: jsonData)
                completion(.success(resources))
            } catch {
                print(error)
                completion(.failure(.decodingError))
            }
        }
        dataTask.resume()
    }
    
    func createGame(_ gameSettings: GameSettings,
                          auth: Auth,
                    completion: @escaping (Result<GameDTO, ResourceRequestError>) -> Void) {
        do {
            guard let token = auth.token else {
                auth.logout()
                return
            }
            var urlRequest = createURLRequest(url: resourceURL, token: token)
            urlRequest.httpBody = try JSONEncoder().encode(gameSettings)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.noData))
                    return
                }
                guard httpResponse.statusCode == 200, let jsonData = data else {
                    if httpResponse.statusCode == 401 {
                        auth.logout()
                    }
                    completion(.failure(.noData))
                    return
                }

                do {
                    let decoder = JSONDateTimeDecoder()
                    let resource = try decoder.decode(GameDTO.self, from: jsonData)
                    completion(.success(resource))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingError))
        }
    }
    
    func getActions(since turn: Int,
                    auth: Auth,
                    completion: @escaping (Result<[GameActionDTO], ResourceRequestError>) -> Void) {
        guard let token = auth.token else {
            auth.logout()
            return
        }
        let urlRequest = createURLRequest(url: URL(string: "\(resourceURL)\(turn)")!, token: token)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noData))
                return
            }
            guard httpResponse.statusCode != 202 else {
                let resources: [GameActionDTO] = []
                completion(.success(resources))
                return
            }
            
            guard let jsonData = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let resources = try JSONDecoder().decode([GameActionDTO].self, from: jsonData)
                completion(.success(resources))
            } catch {
                print(error)
                completion(.failure(.decodingError))
            }
        }
        dataTask.resume()
    }
    
    func submitAction(action: SubmitGameAction,
                      auth: Auth,
                      completion: @escaping (Result<HTTPURLResponse, ResourceRequestError>) -> Void) {
        do {
            guard let token = auth.token else {
                auth.logout()
                return
            }
            var urlRequest = createURLRequest(url: URL(string: "\(resourceURL)")!, token: token)
            urlRequest.httpBody = try JSONEncoder().encode(action)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.noData))
                    return
                }
                guard httpResponse.statusCode == 201 else {
                    if httpResponse.statusCode == 401 {
                        auth.logout()
                    }
                    completion(.failure(.noData))
                    return
                }
    //
    //            do {
    //                let resource = try JSONDecoder().decode(Game.Public.self, from: jsonData)
    //                completion(.success(resource))
    //            } catch {
    //                completion(.failure(.decodingError))
    //            }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingError))
        }
    }
}


struct SubmitGameAction: Codable {
    // Game Action could be as simple as an additional request parameter
    // (cf. my above implementation for getActionsSince),
    // but that's only because TTT is a simple game.
    // Games with more complex actions than a simple int will need this extra complexity in implementation.

    let action: Int
}


