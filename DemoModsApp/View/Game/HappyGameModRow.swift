//
//  HappyGameModRow.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct HappyGameModRow: View {
    var gameMod: HappyGameMod
    @EnvironmentObject var vm : ViewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    var isAdaptive: Bool {
        sizeClass == .compact
    }
    @State var image: UIImage?
    @EnvironmentObject var netManager: NetExamRequset
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    ProgressView()
                        .tint(.black.opacity(0.8))
                }
            }
            .frame(height: 139)
            Spacer()
            VStack {
                Text(gameMod.title)
                    .font(.customFont(font: .montserrat, style: .semiBold, size: .h18))
                    .foregroundStyle(.black)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(gameMod.description)
                    .font(.customFont(font: .inter, style: .regular, size: .h12))
                    .lineLimit(2)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                VStack {
                    NavigationLink {
                        DeteileGame(gameMod: gameMod)
                    } label: {
                        OpenButton()
                    }
                    FavoriteButton(isFavorit: gameMod.isFavorit)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal, 6)
            .padding(.top, 0)
            .padding(.bottom, 6)
        }
        .frame(height: 294)
        .bgCornerRadius18(sizeClass, bgColor: Color.white, strokeColor: Color.colorApp.yellowA)
        .onAppear {
            loadDataFM()
        }
        .onReceive(netManager.$isConnectedToInternet) { isConnected in
            if isConnected {
                loadDataFM()
            }
        }
    }
    
    func loadDataFM() {
        let imagePath = "Games/\(gameMod.image)"
        let filename = (imagePath as NSString).lastPathComponent
        
        let components = imagePath.components(separatedBy: "/")
        guard components.count >= 2 else {
            print("Path doesn't have enough components")
            return
        }
        let savePath = "\(components[components.count - 2])"
        vm.loadImageFM(imagePath: imagePath, filename: filename, savePath: savePath) { loadedImage in
            self.image = loadedImage
        }
    }
}

#Preview {
    HappyGameModRow(gameMod: hmGame[0].hGamesMods[0])
        .environmentObject(ViewModel())
}
