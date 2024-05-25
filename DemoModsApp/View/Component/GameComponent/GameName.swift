//
//  GameName.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct GameName: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var game: HappyGame
    var body: some View {
        HStack {
            Text(game.name)
                .font(.customFont(font: .montserrat, style: .medium, size: .h18))
                .minimumScaleFactor(0.5)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            Image("arrow-up")
                .renderingMode(.template)
                .foregroundStyle(.white)
                .frame(width: 24, height: 24)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .frame(height: 48)
        .frame(maxWidth: .infinity)
        .bgCornerRadius16(sizeClass, bgColor: .colorApp.yellowA, strokeColor: Color.white)
    }
}

#Preview {
    GameName(game: HappyGame(name: "Sport"))
}
