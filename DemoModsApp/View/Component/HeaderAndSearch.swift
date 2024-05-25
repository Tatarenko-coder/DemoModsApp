//
//  HeaderAndSearch.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct HeaderAndSearch: View {
    @Binding var isSearchActive: Bool
    @Binding var searchText: String
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm : ViewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    @FocusState var focus
    var body: some View {
        ZStack {
            BackButton()
            .overlay(alignment: .trailing, content: {
                if isSearchActive {
                    HStack {
                        HStack {
                            Image("search")
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                            TextField("", text: $searchText)
                                .focused($focus)
                                .disableAutocorrection(true)
                                .foregroundStyle(.white)
                                .font(.customFont(font: .montserrat, style: .medium, size: .h14))
                                .background(alignment: .leading) {
                                    Text(searchText == "" ? "Search" : searchText)
                                        .foregroundStyle(Color.colorApp.gr86)
                                        .font(.customFont(font: .montserrat, style: .medium, size: .h14))
                                }
                                .tint(.white)
                        }
                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                                UIApplication.shared.closeKeyboard()
                                isSearchActive = false
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
                } else {
                    HStack {
                        Text("Search")
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .font(.customFont(font: .montserrat, style: .medium, size: .h18))
                            .frame(width: 100, height: 40, alignment: .center)
                            .bgCornerRadius16(sizeClass, bgColor: Color.colorApp.yellowA, strokeColor: Color.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .adaptivePadding()
                    .onTapGesture {
                        isSearchActive.toggle()
                        focus.toggle()
                    }
                }
            })
        }
    }
}

#Preview {
    HeaderAndSearch(isSearchActive: .constant(false), searchText: .constant(""))
}
