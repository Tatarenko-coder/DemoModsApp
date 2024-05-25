//
//  ContentView.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct FinalView: View {
    @State private var selectedTab: TapEnum = .games
    @StateObject private var vm = ViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                switch selectedTab {
                case .games:
                    GamesView()
                case .apps:
                    AppsView()
                case .topics:
                    TopicsView()
                case .favorites:
                    FavoritesView()
                }
                
                TabBarButtons(selectedTab: $selectedTab)
                    .offset(y: vm.openGame ? 300 : 0)
            }
            .background(
                BGUseAll()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    FinalView()
}
