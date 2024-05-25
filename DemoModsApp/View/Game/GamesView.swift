//
//  GamesView.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct GamesView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var searchText = ""
    @EnvironmentObject var vmHM: ViewModel
    var searchGames: [HappyGame] {
        if searchText.isEmpty {
            return vmHM.happyGames
        } else {
            return  vmHM.happyGames.filter { game in
                game.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    @State private var resScroll = UUID()
    private func updateViewOnSearch() {
        resScroll = UUID()
    }
    var body: some View {
        VStack(spacing: 20) {
            SearchTopHeaderView(searchText: $searchText) {
                updateViewOnSearch()
            }
            .padding(.top)
            ScrollView(.vertical, showsIndicators: false) {
                ScrollDetection()
                if searchGames.isEmpty && !searchText.isEmpty {
                    EmpTy()
                } else {
                    LazyVGrid(columns: CCStruct.columns(for: sizeClass), spacing: sizeClass == .compact ? 20 : 24) {
                        ForEach(searchGames) { game in
                            
                            NavigationLink(destination: HappyGameModsView(game: game)) {
                                GameName(game: game)
                            }
                        }
                    }
                    .adaptivePadding()
                    .padding(.bottom, 20)
                }
            }
            .id(resScroll)
            .coordinateSpace(name: "scroll")
        }
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            BGUseAll()
        )

    }
}

#Preview {
    GamesView()
        .environmentObject(ViewModel())
}
