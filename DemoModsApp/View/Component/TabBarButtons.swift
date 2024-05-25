//
//  TabBarButtons.swift
//  DemoModsApp
//
//  Created by TD on 26.05.2024.
//

import SwiftUI

struct TabBarButtons: View {
    @Binding var selectedTab: TabEnum
    @Environment(\.horizontalSizeClass) var sizeClass
    private var isAdaptive: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    var body: some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 100, style: .continuous)
                .fill(Color.colorApp.yellowA)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0.0, y: 4)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 100, style: .continuous)
                        .stroke(lineWidth: 1)
                        .fill(Color.white)
                })
                .overlay(content: {
                    HStack {
                        buttons
                    }
                    .padding(20)
                })
                .frame(height: 80)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .adaptivePadding()
                .padding(.vertical, 20)
                .ignoresSafeArea()
            
        }
    }
    
    var buttons: some View {
        ForEach(tabItems) { tab in
            Button {
                selectedTab = tab.tap
            } label: {
                if sizeClass == .regular {
                    HStack(spacing: 4) {
                        Image(tab.icon)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 32, height: 32)
                        
                        Text(tab.name)
                            .font(.customFont(font: .montserrat, style: .regular, size: .h18))
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    VStack(spacing: 4) {
                        Image(tab.icon)
                            .renderingMode(.template)
                            .frame(width: 24, height: 24)
                        
                        Text(tab.name)
                            .font(.customFont(font: .montserrat, style: .regular, size: .h12))
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .foregroundStyle(selectedTab == tab.tap ? Color.white : .colorApp.gr72)
        }
    }
}

#Preview {
    TabBarButtons(selectedTab: .constant(.games))
}
