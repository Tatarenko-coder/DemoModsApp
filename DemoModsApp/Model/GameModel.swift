//
//  GameModel.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import Foundation

struct GameData: Codable {
    let name: [String : [ModJSONs]]
    
    enum CodingKeysHappyDataGame: String, CodingKey {
        case name = "games345"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeysHappyDataGame.self)
        self.name = try container.decode([String : [ModJSONs]].self, forKey: .name)
    }
}
struct ModJSONs:  Codable {
    var title: String
    var description: String
    var image:  String
    var file: String?
    var isFavorit: Bool = false
    
    enum CodingKeysModGames: String, CodingKey, Codable {
        case title = "titled32sda"
        case description = "desmc438hf"
        case image = "imgf43fdasf433"
        case file = "file67fg43"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeysModGames.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.image = try container.decode(String.self, forKey: .image)
        self.file = try container.decodeIfPresent(String.self, forKey: .file)
    }
}

struct HappyGame: Identifiable, Codable, Equatable {
    static func == (lhs: HappyGame, rhs: HappyGame) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    var name = ""
    var hGamesMods: [HappyGameMod] = []
}

struct HappyGameMod: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var image:  String
    var file: String?
    var isFavorit: Bool = false
}
