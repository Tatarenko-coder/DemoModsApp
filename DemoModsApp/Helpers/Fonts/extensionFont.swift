//
//  extensionFont.swift
//  DemoHappyMod
//
//  Created by TD on 22.05.2024.
//

import Foundation
import SwiftUI

enum CustumFont: String {
    case montserrat = "Montserrat"
    case inter = "Inter"
}

enum CustomFStyle: String {
    case bold = "-Bold"
    case regular = "-Regular"
    case medium = "-Medium"
    case semiBold = "-SemiBold"
}

enum CustomFSize: CGFloat {
    case h24 = 24.0
    case h20 = 20.0
    case h18 = 18.0
    case h16 = 16.0
    case h14 = 14.0
    case h12 = 12.0
}

extension Font {
    static func customFont(
        font: CustumFont,
        style: CustomFStyle,
        size: CustomFSize,
        isScaled: Bool = true) -> Font {
            
            let fontName: String = font.rawValue + style.rawValue
            return Font.custom(fontName, size: size.rawValue)
        
    }
}
