//
//  AppTypography.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 12/12/25.
//

import Foundation
import SwiftUI

// MARK: - Environment Key
private struct FontScaleKey: EnvironmentKey {
    static let defaultValue: CGFloat = 1.0
}

extension EnvironmentValues {
    var fontScale: CGFloat {
        get { self[FontScaleKey.self] }
        set { self[FontScaleKey.self] = newValue }
    }
}

// MARK: - Typography System
extension Font {
    
    // MARK: Display (Títulos grandes - Onboarding, Splash)
    static func displayLarge(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 34 * scale, weight: .bold, design: .rounded)
    }
    
    static func displayMedium(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 28 * scale, weight: .bold, design: .rounded)
    }
    
    static func displaySmall(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 24 * scale, weight: .semibold, design: .rounded)
    }
    
    // MARK: Headline (Títulos de seções, nomes de mídia)
    static func headlineLarge(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 20 * scale, weight: .bold, design: .default)
    }
    
    static func headlineMedium(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 18 * scale, weight: .semibold, design: .default)
    }
    
    static func headlineSmall(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 16 * scale, weight: .semibold, design: .default)
    }
    
    // MARK: Body (Descrições, sinopses, textos gerais)
    static func bodyLarge(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 20 * scale, weight: .regular, design: .default)
    }
    
    static func bodyMedium(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 16 * scale, weight: .regular, design: .default)
    }
    
    static func bodySmall(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 13 * scale, weight: .regular, design: .default)
    }
    
    // MARK: Label (Botões, chips, badges, metadados)
    static func labelLarge(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 16 * scale, weight: .medium, design: .default)
    }
    
    static func labelMedium(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 14 * scale, weight: .medium, design: .default)
    }
    
    static func labelSmall(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 12 * scale, weight: .medium, design: .default)
    }
    
    // MARK: Caption (Informações secundárias, datas, duração)
    static func captionLarge(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 13 * scale, weight: .regular, design: .default)
    }
    
    static func captionMedium(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 12 * scale, weight: .regular, design: .default)
    }
    
    static func captionSmall(scale: CGFloat = 1.0) -> Font {
        Font.system(size: 11 * scale, weight: .regular, design: .default)
    }
    
    // MARK: Computed Properties (sem scale)
    static var displayLarge: Font { displayLarge() }
    static var displayMedium: Font { displayMedium() }
    static var displaySmall: Font { displaySmall() }
    static var headlineLarge: Font { headlineLarge() }
    static var headlineMedium: Font { headlineMedium() }
    static var headlineSmall: Font { headlineSmall() }
    static var bodyLarge: Font { bodyLarge() }
    static var bodyMedium: Font { bodyMedium() }
    static var bodySmall: Font { bodySmall() }
    static var labelLarge: Font { labelLarge() }
    static var labelMedium: Font { labelMedium() }
    static var labelSmall: Font { labelSmall() }
    static var captionLarge: Font { captionLarge() }
    static var captionMedium: Font { captionMedium() }
    static var captionSmall: Font { captionSmall() }
}

#Preview {
    ContentView()
}
