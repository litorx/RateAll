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
    let textTertiary: Color
    let progressBarBackground: Color
    
    
    var backgroundGradient: LinearGradient {
        LinearGradient(colors: [bgStart, bgEnd], startPoint: .bottom, endPoint: .top)
    }
    
    var cardsGradient: LinearGradient {
        LinearGradient(colors: [cardStart, cardEnd], startPoint: .bottom, endPoint: .top)
    }
    
    static let dark = AppColors(
        

        bgStart: Color(hex: "0B0B0F"),
        bgEnd: Color(hex: "1C1C21"),
        cardStart: Color(hex: "18181D"),
        cardEnd: Color(hex: "2A2A35"),
        accent1: Color(hex: "FF3366"),
        accent2: Color(hex: "00FFC6"),
        textPrimary: Color(hex: "FAFAFA"),
        textSecondary: Color(hex: "D5D5D9"),
        textTertiary: Color(hex: "B0B0B8"),
        progressBarBackground: Color(hex: "#40FFFFFF")
        
        

        
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

#Preview {
    SplashView()
}
