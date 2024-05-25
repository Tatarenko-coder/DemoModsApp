//
//  FavoriteButton.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct FavoriteButton: View {
    @State private var buttonEnabled = true
    @Environment(\.horizontalSizeClass) var sizeClass
    var isFavorit: Bool
    var body: some View {
        Button {
//           vm.toggleFavoriteGames(for: gameMod.id)
            disableButtonWithDelay()
        } label: {
            HStack {
                Text("Favorite")
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .font(.customFont(font: .montserrat, style: .semiBold, size: .h14))
                    .foregroundStyle(isFavorit ? Color.white : Color.black)
                    
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .bgCornerRadius12(sizeClass, bgColor: isFavorit ? Color.colorApp.yellowA : Color.lightGr, strokeColor: isFavorit ? Color.white : Color.colorApp.yellowA)
            .overlay(alignment: .trailing) {
                if isFavorit {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12).weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.trailing, 12)
                }
            }
        }
        .disabled(!buttonEnabled)
    }
    
    func disableButtonWithDelay() {
        buttonEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            buttonEnabled = true
        }
    }
}

#Preview {
    FavoriteButton(isFavorit: false)
}
