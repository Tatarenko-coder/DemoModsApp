//
//  AlertErrorDownload.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import SwiftUI

struct AlertErrorDownload: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Binding var showError: Bool
    var retryAction: () -> Void
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 8) {
                Text("The download was unsuccessful")
                    .font(.customFont(font: .montserrat, style: .semiBold, size: .h20))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    
                Text("Do you want to retry the download?")
                    .font(.customFont(font: .montserrat, style: .regular, size: .h16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .frame(width: 310, height: 19)
            }
            HStack(spacing: 10) {
                Button {
                    showError = false
                } label: {
                    Text("No")
                        .font(.customFont(font: .montserrat, style: .medium, size: .h18))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity,alignment: .center)
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity,alignment: .leading)
                .bgCornerRadius8(sizeClass, bgColor: .colorApp.redApp, strokeColor: .white)
                Button {
                    retryAction()
                } label: {
                    Text("Yes")
                        .font(.customFont(font: .montserrat, style: .medium, size: .h18))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity,alignment: .center)
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity,alignment: .trailing)
                .bgCornerRadius8(sizeClass, bgColor: .colorApp.yellowA, strokeColor: .white)
            }
            
        }
        .padding(20)
        .frame(width: 350)
        .bgCornerRadius16(sizeClass, bgColor: .colorApp.darkGr, strokeColor: .white)

    }
}

#Preview {
    AlertLoad()
}


struct AlertDownload: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        ZStack {
            VStack {
                Text("Download Successful")
                    .font(.customFont(font: .montserrat, style: .semiBold, size: .h20))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(20)
                    .frame(width: 350)
                    .bgCornerRadius16(sizeClass, bgColor: .colorApp.darkGr, strokeColor: .white)
            }
        }
    }
}

struct AlertLoad: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var progress: CGFloat = 0
    @State var animate: Bool = false
    var body: some View {
        ZStack {
            Circle()
                .stroke(.ultraThinMaterial, lineWidth: 5)
                .frame(width: 75, height: 75)
            Circle()
                .trim(from: 0 , to: CGFloat(progress / 100))
                .stroke(Color.colorApp.darkGr, lineWidth: 5)
                .frame(width: 75, height: 75)
                .rotationEffect(.degrees(-90))
            
            Text("\(Int(progress))%")
                .font(.customFont(font: .montserrat, style: .semiBold, size: .h20))
                .scaleEffect(CGSize(width: animate ? 1.8 : 1.0, height: animate ? 1.8 : 1.0))
                
        }
        .onAppear {
            animationProgress()
            addAnimation()
        }
    }
    
    func animationProgress() {
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            if progress < 99 {
                progress += 1
            } else {
                timer.invalidate()
            }
        }
        .fire()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            progress = 99
        }
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.global(qos: . background).asyncAfter(deadline: .now()) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.5)
                    .repeatForever(autoreverses: .init(truncating: 0.5))
            ) {
                animate.toggle()
            }
        }
    }
}

