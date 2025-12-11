//
//  Colors.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 11/12/25.
//

import Foundation
import SwiftUI

struct AppColors{
    
    let bgStart: Color
    let bgEnd: Color
    let cardStart: Color
    let cardEnd: Color
    let accent1: Color
    let accent2: Color
    let textPrimary: Color
    let textSecondary: Color
    
    static let dark = AppColors(
        
        bgStart: Color(hex: "0A0E27"),
        bgEnd: Color(hex: "0A0E27"),
        cardStart: Color (hex: "1C2447"),
        cardEnd: Color(hex: "1C2447"),
        accent1: Color(hex: "FFD700"),
        accent2: Color(hex: "6C5CE7"),
        textPrimary: Color(hex: "FFFFFF"),
        textSecondary: Color(hex: "A0A0B8")
        
    )
    
}

    extension Color {
        init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3:
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6:
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8:
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
            }
            self.init(
                .sRGB,
                red: Double(r) / 255,
                green: Double(g) / 255,
                blue: Double(b) / 255,
                opacity: Double(a) / 255
            )
        }
    }
