//
//  DeteileGame.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct DeteileGame: View {
    var gameMod: HappyGameMod
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm : ViewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var isSave = false
    @State private var showSaveFile = false
    @State private var showSuccess = false
    @State private var showErrorDow = false
    @State private var showIsLoad = false
    var isAdaptive: Bool {
        sizeClass == .compact
    }
    let fileManager = UniversalLMHalper.instanse
    @State private var destinationURL: URL?
    @State var image: UIImage?
    @EnvironmentObject var netManager: NetExamRequset
    var body: some View {
        VStack(spacing: 20) {
            HeaderButtonsDeteileMod(isSave: gameMod.isFavorit) {
//                vm.toggleFavoriteGames(for: gameMod.id)
            }
            .padding(.top)
            ScrollView(.vertical, showsIndicators: false) {
                ScrollDetection()
                VStack(spacing: 18) {
                    ZStack {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            ProgressView()
                                .tint(.black.opacity(0.8))
                                .frame(height: isAdaptive ? 248 : 520)
                        }
                        
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(gameMod.title)
                                .font(.customFont(font: .montserrat, style: .semiBold, size: .h24))
                                .foregroundStyle(.black)
                            Text(gameMod.description)
                                .font(.customFont(font: .montserrat, style: .regular, size: .h16))
                                .foregroundStyle(.black)
                        }
                        Button {
                            downloadGame()
                        } label: {
                            Text("Download")
                                .font(.customFont(font: .montserrat, style: .bold, size: .h18))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(height: sizeClass == .compact ? 48 : 54)
                                .bgCornerRadius12(sizeClass, bgColor: Color.colorApp.yellowA, strokeColor: Color.white)
                            
                        }
                    }
                    .padding(.top, 0)
                    .padding(.leading, 12)
                    .padding(.trailing, 12)
                    .padding(.bottom, 12)
                }
                .bgCornerRadius24(sizeClass, bgColor: Color.white, strokeColor: Color.colorApp.yellowA)
                .adaptivePadding()
            }
            .coordinateSpace(name: "scroll")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
        .background(BGUseAll())
        .onAppear {
//            requestManager.checkNetConnection()
            vm.openGame = true
            loadDataFM()
        }
        .onReceive(netManager.$isConnectedToInternet) { isConnected in
            if isConnected {
                loadDataFM()
            }
        }
        .gesture(
            DragGesture()
                .onEnded { val in
                    if val.translation.width > 90  {
                        withAnimation(.easeInOut) {
                            dismiss()
                            vm.openGame = false
                        }
                    }
                })
        .overlay(alignment: .center) {
            if  showErrorDow {
                AlertErrorDownload(showError: $showErrorDow) {
                    showErrorDow = false
                    downloadGame()
                }
            }
            if showSuccess {
                AlertDownload()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showSuccess = false
                        }
                    }
            }
            if showIsLoad {
                AlertLoad()
            }
        }
    }
    func downloadGame() {
        showIsLoad = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showIsLoad = false
            if let fileName = gameMod.file {
                let filePath = "Games/\(fileName)"
                DBManager.shared.getFile(path: filePath) { dropboxLink in
   
                        guard let dropboxLink = dropboxLink else {
                            showErrorDow = true
                            print("Error: Unable to get file from DropBox")
                            return
                        }
                        guard let dropboxURL = URL(string: dropboxLink) else {
                            showErrorDow = true
                            print("Error: Invalid DropBox URL")
                            return
                        }
                    
                        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        
                       fileManager.saveFileDropBox(named: fileName, from: dropboxURL, to: documentsDirectory) { _ in
                            showSuccess = true
                            print("Save file")
                        }
                }
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
    DeteileGame(gameMod: hmGame[0].hGamesMods[0])
        .environmentObject(ViewModel())
}
