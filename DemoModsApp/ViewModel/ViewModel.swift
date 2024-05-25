//
//  ViewModel.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import Foundation
import UIKit


class ViewModel: ObservableObject {
    static let shared = ViewModel()
    private let fm = UniversalFMHelper.shared
    private let fileManager = UniversalLMHalper.instanse
    
    @Published var openGame: Bool = false
    
    @Published var happyGames: [HappyGame] = [] {
        didSet {
            saveHappyGames()
        }
    }
    
    init() {
        loadArrayGames()
        fm.clearAllCache(keys: [keyName])
    }
    
    private let keyName = "gKey"
    
    func addHappyGames(_ games: [HappyGame]) {
        happyGames.append(contentsOf: games)
    }
    
    func loadArrayGames() {
        if let loadedHappyGames: [HappyGame] = fm.load(from: keyName) {
            happyGames = loadedHappyGames
            print("Loaded game from file!")
        } else {
            print("Fetch Game")
        }
    }
    
    func saveHappyGames() {
        fm.save(happyGames, to: keyName)
        print("Save game to file!")
    }
    
    func clearArrayGames() {
        happyGames.removeAll()
        print("remove Games Array!!!!!!")
    }
    
    func loadImageFM(imagePath: String, filename: String, savePath: String, completion: @escaping (UIImage?) -> Void) {
        if let loadedImage = fileManager.loadImageFromFile(filename: filename, savePath: savePath) {
            completion(loadedImage)
        } else {
            DBManager.shared.getImage(path: imagePath) { string in
                if let urlString = string, let url = URL(string: urlString) {
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data, error == nil else {
                            completion(nil)
                            return
                        }
                        self.fileManager.saveImageToFile(image: UIImage(data: data)!, filename: filename, savePath: savePath)
                        DispatchQueue.main.async {
                            completion(UIImage(data: data))
                        }
                    }.resume()
                } else {
                    completion(nil)
                }
            }
        }
    }
}
