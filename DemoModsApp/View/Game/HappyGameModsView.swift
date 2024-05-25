//
//  HappyGameModsView.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct HappyGameModsView: View {
    @EnvironmentObject var vm : ViewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    var game: HappyGame
    private var searchMods: [HappyGameMod] {
        if searchText.isEmpty {
            return game.hGamesMods
        } else {
            return game.hGamesMods.filter { mod in
                mod.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    private var isAdaptive: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    @State private var isSearchActive = false
    @State private var showError = false
    @State private var resScroll = UUID()
    private func updateViewOnSearch() {
        resScroll = UUID()
    }
    var body: some View {
        VStack {
            HeaderAndSearch(isSearchActive: $isSearchActive, searchText: $searchText)
                .padding(.top)
            ScrollView(.vertical, showsIndicators: false) {
                ScrollDetection()
                if searchMods.isEmpty || (searchMods.isEmpty && !searchText.isEmpty) {
                    Text("Empty")
                        .padding(.top, 201)
                        .padding(.vertical, 32)
                        .padding(.horizontal, 12)
                        .foregroundStyle(.black)
                        .font(.customFont(font: .montserrat, style: .medium, size: .h18))
                } else {
                    LazyVGrid(columns: CCStruct.columns(for: sizeClass), spacing: isAdaptive ? 20 : 32) {
                        ForEach(searchMods) { gameMod in
                            HappyGameModRow(gameMod: gameMod)
                        }
                    }
                    .adaptivePadding()
                    .padding(.vertical, isAdaptive ? 20 : 32)
                }
            }
            .id(resScroll)
            .coordinateSpace(name: "scroll")
            .onTapGesture {
                UIApplication.shared.closeKeyboard()
                if searchText.isEmpty {
                    isSearchActive = false
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            BGUseAll()
        )
        .onAppear {
            vm.openGame = true
        }
        .gesture(
            DragGesture()
                .onEnded { val in
                    if val.translation.width > 90  {
                        withAnimation(.easeInOut) {
                            dismiss()
                            vm.openGame = false
                        }
                    }
                }
        )
        .onChange(of: isSearchActive) { newValue in
            if newValue == true {
                updateViewOnSearch()
            }
        }
    }
}

#Preview {
    HappyGameModsView(game: hmGame[0])
        .environmentObject(ViewModel())
}
