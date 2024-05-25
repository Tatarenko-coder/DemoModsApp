//
//  DBManager.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import Foundation
import SwiftyDropbox
import SwiftUI

class DBManager: ObservableObject {
    
    static let shared = DBManager()
    
    private var vm = ViewModel.shared
    
    var client: DropboxClient?

    private init() { initialize_DropBoxHM() }
    
    func initialize_DropBoxHM() {
        Task {
            do {
//                let token = try await getRefreshToken(code: DBKeys.token)
                try await checkAccessToken(DBKeys.refresh_token)
                await fetchData_HM()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData_HM() async {
        fetchGames()
        fetchApps()
        fetchTopics()
    }
    
    func fetchGames() {
        print("Data games: [game] ")
        client?.files.download(path: DBKeys.gamesFilePath)
            .response(completionHandler: { [weak self] response, error in
                guard let self else { return }
                if let response {
                    let fileJson = response.1
//                    print("DropBoxAPI data json: \(String(data: fileContents, encoding: .utf8) ?? "Unable to convert data to string")")
                    do {
                        let games = try JSONDecoder().decode(GameData.self, from: fileJson)
                        
                        let gamesCount = games.name.count
                        let previousGamesCount = self.vm.happyGames.count
                 
                        let modsCount = games.name.flatMap { $0.value }.count
                        let previousModsCount = self.vm.happyGames.flatMap { $0.hGamesMods }.count
                       
                        guard gamesCount != previousGamesCount || modsCount != previousModsCount else {
                            print("The number of games and the number of game mods have not changed, we skip decoding.")
                            return
                        }
                        
                        self.vm.clearArrayGames()
                        var newHappyGames: [HappyGame] = []
                        for game in games.name {
                            let happyGame = game.value.map { mod in
                                HappyGameMod(title: mod.title,
                                            description: mod.description,
                                             image: mod.image, file: mod.file, isFavorit: mod.isFavorit)
                            }
                            newHappyGames.append(HappyGame(name: game.key, hGamesMods:  happyGame))
                        }
                        self.vm.addHappyGames(newHappyGames)
                
                    } catch {
                        print(error.localizedDescription)
                    }
                } else if let error = error {
                    print(error)
                }
            })
    }
    
    func fetchApps() {
        print("Data apps: [apps]")
    }
    
    func fetchTopics() {
        print("Data topics: [topics]")
    }
   
    private func checkAccessToken(_ token: String) async throws {
        let loginString = String(format: "%@:%@", DBKeys.appkey, DBKeys.appSecret)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let parameters: Data = "refresh_token=\(token)&grant_type=refresh_token".data(using: .utf8)!
        print("Request parameters: \(parameters)")
        let url = URL(string: DBKeys.apiLink)!
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "POST"
        apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = parameters
        do {
            let responseJSON = try await fetchData(from: apiRequest)
            print("Response JSON: \(responseJSON)")
            
            if let accessToken = responseJSON[DBKeys.accessTokenName] as? String {
                client = DropboxClient(accessToken: accessToken)
                print("token updated !!! \(accessToken),\(String(describing: self.client))")
            } else {
                throw NetworkErrorHM.noData
            }
            
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
    
    private func getRefreshToken(code: String) async throws -> String {
        let username = DBKeys.appkey
        let password = DBKeys.appSecret
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let parameters: Data = "code=\(code)&grant_type=authorization_code".data(using: .utf8)!
        let url = URL(string: DBKeys.apiLink)!
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "POST"
        apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = parameters
        do {
            let responseJSON = try await fetchData(from: apiRequest)
            if let token = responseJSON[DBKeys.refreshTokenName] as? String {
                print("refresh token API Dropbox: \(token)")
                return token
            }
        } catch NetworkErrorHM.noData {
            print("No data available")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        throw NetworkErrorHM.noData
    }

    func fetchData(from apiRequest: URLRequest) async throws -> [String: Any] {
        let (data, response) = try await URLSession.shared.data(for: apiRequest)
        print(data, response)
        guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NetworkErrorHM.serializationError
        }
        print(jsonData)
        return jsonData
    }
    

    func getImage(path: String, completion: @escaping (String?) -> ()) {
        self.client?.files.getTemporaryLink(path: "/\(path)").response(completionHandler: { responce, error in
            if let link = responce {
                completion(link.link)
            } else {
                completion(nil)
            }
        })
    }
    
    func getFile(path: String, completion: @escaping (String?) -> ()) {
        self.client?.files.getTemporaryLink(path: "/\(path)").response(completionHandler: { responce, error in
            if let link = responce {
                completion(link.link)
            } else {
                completion(nil)
            }
        })
    }
}

enum NetworkErrorHM: Error {
    case noData , serializationError
}
