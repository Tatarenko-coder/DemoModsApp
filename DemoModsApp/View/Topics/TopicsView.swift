//
//  TopicsView.swift
//  DemoModsApp
//
//  Created by TD on 26.05.2024.
//

import SwiftUI

struct TopicsView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var searchText = ""
    @EnvironmentObject var vmHM: ViewModel
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
                EmpTy()
            }
            .id(resScroll)
            .coordinateSpace(name: "scroll")
        }
    }
}

#Preview {
    TopicsView()
}
