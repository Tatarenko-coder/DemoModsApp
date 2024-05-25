//
//  OpenButton.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct OpenButton: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        Text("Open")
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .font(.customFont(font: .montserrat, style: .semiBold, size: .h14))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .center)
            .bgCornerRadius12(sizeClass, bgColor: Color.colorApp.yellowA, strokeColor: Color.white)
    }
}

#Preview {
    OpenButton()
}
