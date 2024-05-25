//
//  HelperModifier.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import Foundation
import SwiftUI
import Combine


struct CCStruct {
    static func columns(for sizeClass: UserInterfaceSizeClass?) -> [GridItem] {
        guard let sizeClass = sizeClass else {
            return Array(repeating: .init(.adaptive(minimum: 350), spacing: 20), count: 2)
        }
        switch sizeClass {
        case .compact:
            return Array(repeating: .init(.adaptive(minimum: 350), spacing: 20), count: 2)
        default:
            return Array(repeating: .init(.flexible(), spacing: 24), count: 3)
        }
    }
}

struct AdaptivePadding: ViewModifier {
    @Environment(\.horizontalSizeClass) var sizeClass
    func body(content: Content) -> some View {
        let paddingH = sizeClass == .compact ? CGFloat(20) : CGFloat(85)
        return content.padding(.horizontal, paddingH)
    }
}

struct AdaptivePaddingV: ViewModifier {
    @Environment(\.horizontalSizeClass) var sizeClass
    func body(content: Content) -> some View {
        let paddingH = sizeClass == .compact ? CGFloat(0) : CGFloat(40)
        return content.padding(.vertical, paddingH)
    }
}

struct Corner8: ViewModifier {
    var sizeClass: UserInterfaceSizeClass?
    var bgColor: Color
    var strokeColor: Color
    func body(content: Content) -> some View {
        let cornerRadius: CGFloat = sizeClass == .compact ? 8 : 10
        
        return content
            .background(bgColor, in: RoundedRectangle(cornerRadius: cornerRadius))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(content: {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(lineWidth: 1)
                    .fill(strokeColor)
            })
    }
}

struct Corner12: ViewModifier {
    var sizeClass: UserInterfaceSizeClass?
    var bgColor: Color
    var strokeColor: Color
    func body(content: Content) -> some View {
        let cornerRadius: CGFloat = sizeClass == .compact ? 12 : 14
        
        return content
            .background(bgColor, in: RoundedRectangle(cornerRadius: cornerRadius))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(content: {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(lineWidth: 1)
                    .fill(strokeColor)
            })
    }
}

struct Corner16: ViewModifier {
    var sizeClass: UserInterfaceSizeClass?
    var bgColor: Color
    var strokeColor: Color
    func body(content: Content) -> some View {
        let cornerRadius: CGFloat = sizeClass == .compact ? 16 : 18
        
        return content
            .background(bgColor, in: RoundedRectangle(cornerRadius: cornerRadius))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(content: {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(lineWidth: 1)
                    .fill(strokeColor)
            })
    }
}

struct Corner18: ViewModifier {
    var sizeClass: UserInterfaceSizeClass?
    var bgColor: Color
    var strokeColor: Color
    func body(content: Content) -> some View {
        let cornerRadius: CGFloat = sizeClass == .compact ? 18 : 20
        
        return content
            .background(bgColor, in: RoundedRectangle(cornerRadius: cornerRadius))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(content: {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(lineWidth: 1)
                    .fill(strokeColor)
            })
    }
}

struct Corner24: ViewModifier {
    var sizeClass: UserInterfaceSizeClass?
    var bgColor: Color
    var strokeColor: Color
    func body(content: Content) -> some View {
        let cornerRadius: CGFloat = sizeClass == .compact ? 24 : 26
        
        return content
            .background(bgColor, in: RoundedRectangle(cornerRadius: cornerRadius))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(content: {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(lineWidth: 1)
                    .fill(strokeColor)
            })
    }
}


typealias UseModifiarView = View
extension UseModifiarView {
    func adaptivePadding() -> some View {
        self.modifier(AdaptivePadding())
    }
    
    func adaptivePaddingV() -> some View {
        self.modifier(AdaptivePaddingV())
    }
    
    func bgCornerRadius8(_ sizeClass: UserInterfaceSizeClass?, bgColor: Color, strokeColor: Color) -> some View {
        self.modifier(Corner8(sizeClass: sizeClass, bgColor: bgColor, strokeColor: strokeColor))
    }
    
    func bgCornerRadius12(_ sizeClass: UserInterfaceSizeClass?, bgColor: Color, strokeColor: Color) -> some View {
        self.modifier(Corner12(sizeClass: sizeClass, bgColor: bgColor, strokeColor: strokeColor))
    }
    
    func bgCornerRadius16(_ sizeClass: UserInterfaceSizeClass?, bgColor: Color, strokeColor: Color) -> some View {
        self.modifier(Corner16(sizeClass: sizeClass, bgColor: bgColor, strokeColor: strokeColor))
    }
    
    func bgCornerRadius18(_ sizeClass: UserInterfaceSizeClass?, bgColor: Color, strokeColor: Color) -> some View {
        self.modifier(Corner18(sizeClass: sizeClass, bgColor: bgColor, strokeColor: strokeColor))
    }
    
    func bgCornerRadius24(_ sizeClass: UserInterfaceSizeClass?, bgColor: Color, strokeColor: Color) -> some View {
        self.modifier(Corner24(sizeClass: sizeClass, bgColor: bgColor, strokeColor: strokeColor))
    }
}


typealias AppColor = Color
extension AppColor {
    static let colorApp = UColors()
}

struct UColors {
    let yellowA = Color("YellowApp")
    let bg1 = Color("Bg1App")
    let bg2 = Color("Bg2App")
    let lightGr = Color("LightGr")
    let darkGr = Color("DarkGr")
    let gr72 = Color("Gr72")
    let gr86 = Color("Gr86")
    let gr05 = Color("Gr05")
    let redApp = Color("redApp")
    
}

typealias UseUIApplication =  UIApplication
extension UseUIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


typealias PablisherWillShow = Publishers
extension PablisherWillShow {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
            .map { $0.height }

        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
