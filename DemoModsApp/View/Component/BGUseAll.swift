//
//  BGUseAll.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct BGUseAll: View {
    var body: some View {
        LinearGradient(colors: [Color.colorApp.bg1, Color.colorApp.bg2], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

#Preview {
    BGUseAll()
}
