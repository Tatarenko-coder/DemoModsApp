//
//  StaticVar.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import Foundation


var hmGame = [
    HappyGame(
        name: "Music",
        hGamesMods: [
            HappyGameMod(
                title: "Keylimba Mod Apk 6.6 [Unlimited money][Free purchase][Full]",
                description: " Unlock all features and unlimited money to enjoy the full Keylimba kalimba learning experience for free! (This assumes Keylimba is a kalimba learning app)",
                image: "ac29.png",
                file: Optional("io5h702351K221CJ8V0.apk"),
                isFavorit: false),
            HappyGameMod(
                title: "Beat Beast Mod Apk 0.2",
                description: " Test out and play as trick characters",
                image: "ac28.png",
                file: Optional("ipq29493Dr1z25t8gCb.apk"),
                isFavorit: false),
            HappyGameMod(
                title: "Keylimba Mod Apk 6.6 [Unlimited money][Free purchase][Full]",
                description: " Unlock all features and unlimited money to enjoy the full Keylimba kalimba learning experience for free! (This assumes Keylimba is a kalimba learning app)",
                image: "ac29.png",
                file: Optional("io5h702351K221CJ8V0.apk"),
                isFavorit: false),
            HappyGameMod(
                title: "Beat Beast Mod Apk 0.2",
                description: " Test out and play as trick characters",
                image: "ac28.png",
                file: Optional("ipq29493Dr1z25t8gCb.apk"),
                isFavorit: false)
        ]
    )
]


var tabItems = [
    TabModel(name: "Games", icon: "games", tap: .games),
    TabModel(name: "Apps", icon: "apps", tap: .apps),
    TabModel(name: "Topics", icon: "topics", tap: .topics),
    TabModel(name: "Favorites", icon: "favorites", tap: .favorites),
]
