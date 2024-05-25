//
//  TabModel.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import Foundation

struct TabModel: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
    var tap: TabEnum
}

enum TabEnum: String {
    case games, apps, topics, favorites
}
