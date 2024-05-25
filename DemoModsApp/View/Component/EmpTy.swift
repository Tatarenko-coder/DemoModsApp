//
//  EmpTy.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct EmpTy: View {
    var body: some View {
        Text("Empty")
            .padding(.top, 201)
            .padding(.vertical, 32)
            .padding(.horizontal, 12)
            .foregroundStyle(.black)
            .font(.customFont(font: .montserrat, style: .medium, size: .h18))
    }
}

#Preview {
    EmpTy()
}
