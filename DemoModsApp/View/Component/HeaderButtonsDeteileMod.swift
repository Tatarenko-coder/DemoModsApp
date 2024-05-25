//
//  HeaderButtonsDeteileMod.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct HeaderButtonsDeteileMod: View {
    @State private var isSearchActive = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm : ViewModel
    var isSave: Bool
    var favoritToggle: () -> Void
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        ZStack {
            HStack {
                BackButton()
                Button {
                    withAnimation(.easeInOut) {
                        favoritToggle()
                    }
                } label: {
                    HStack {
                        Text("Favorite")
                            .foregroundStyle(isSave ? Color.white : Color.black)
                            .font(.customFont(font: .montserrat, style: .medium, size: .h18))
                    }
                    .padding(16)
                    .frame(height: 40, alignment: .center)
                    .bgCornerRadius12(sizeClass, bgColor: isSave ? Color.colorApp.yellowA : Color.colorApp.lightGr, strokeColor: isSave ? Color.white : Color.colorApp.yellowA)
                    
                }
                .adaptivePadding()
            }
        }
    }
}

#Preview {
    HeaderButtonsDeteileMod(isSave: false) { }
}
