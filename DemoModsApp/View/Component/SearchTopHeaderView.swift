//
//  SearchTopHeaderView.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct SearchTopHeaderView: View {
    @Binding var searchText: String
    @Namespace var namespace
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var vm : ViewModel
    var focus: () -> Void
    var body: some View {
        ZStack {
            HStack {
                HStack {
                    Image("search")
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                    TextField("", text: $searchText)
                        .disableAutocorrection(true)
                        .foregroundStyle(.white)
                        .font(.customFont(font: .montserrat, style: .medium, size: .h14))
                        .background(alignment: .leading) {
                            Text(searchText == "" ? "Search" : searchText)
                                .foregroundStyle(Color.colorApp.gr86)
                                .font(.customFont(font: .montserrat, style: .medium, size: .h14))
                                
                        }
                        .tint(.white)
                        .onTapGesture {
                            focus()
                        }
                        
                        
                }
                if !searchText.isEmpty {
                    Button {
                            searchText = ""
                            UIApplication.shared.closeKeyboard()
                        
                    } label: {
                        Image("close")
                            .renderingMode(.template)
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .bgCornerRadius16(sizeClass, bgColor: Color.colorApp.yellowA, strokeColor: Color.white)
            .adaptivePadding()
        }
    }
}

#Preview {
    SearchTopHeaderView(searchText: .constant("")) { }
}
