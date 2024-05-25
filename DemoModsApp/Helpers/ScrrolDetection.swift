//
//  ScrrolDetections.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct ScrollDetection: View {
    var body: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: PreferenceKeyBestScroll.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
    }
}

#Preview {
    ScrollDetection()
}

struct PreferenceKeyBestScroll: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
