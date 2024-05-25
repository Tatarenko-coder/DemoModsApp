//
//  BackButton.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm : ViewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        HStack {
            Button {
                withAnimation(.easeInOut) {
                    dismiss()
                    vm.openGame = false
                }
            } label: {
                Text("Back")
                    .foregroundStyle(.white)
                    .padding(16)
                    .frame(height: 40, alignment: .center)
                    .font(.customFont(font: .montserrat, style: .medium, size: .h18))
                    .frame(width: 100, height: 40, alignment: .center)
                    .bgCornerRadius16(sizeClass, bgColor: Color.colorApp.yellowA, strokeColor: Color.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .adaptivePadding()
    }
}

#Preview {
    BackButton()
}
