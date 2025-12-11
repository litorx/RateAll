import SwiftUI

// MARK: - Color Palettes
enum ColorPalette {
    case darkPremium      // Original
    case purpleGradient   // Roxo moderno
    case blueNeon         // Azul neon tech
    case sunsetGlow       // Pôr do sol vibrante
    
    var colors: PaletteColors {
        switch self {
        case .darkPremium:
            return PaletteColors(
                bgStart: "0A0E27",
                bgEnd: "0A0E27",
                cardStart: "1C2447",
                cardEnd: "1C2447",
                accent1: "FFD700",
                accent2: "6C5CE7",
                textPrimary: "FFFFFF",
                textSecondary: "A0A0B8"
            )
            
        case .purpleGradient:
            return PaletteColors(
                bgStart: "0F0C29",      // Roxo escuro profundo
                bgEnd: "302B63",        // Roxo médio
                cardStart: "24243e",    // Roxo card escuro
                cardEnd: "302b63",      // Roxo card claro
                accent1: "FFD700",      // Dourado (estrelas)
                accent2: "A8C0FF",      // Azul claro suave
                textPrimary: "FFFFFF",
                textSecondary: "B8B8D1"
            )
            
        case .blueNeon:
            return PaletteColors(
                bgStart: "0A192F",      // Azul marinho profundo
                bgEnd: "1E3A5F",        // Azul médio
                cardStart: "112240",    // Card azul escuro
                cardEnd: "1E3A5F",      // Card azul claro
                accent1: "00D9FF",      // Ciano neon
                accent2: "FF2E97",      // Rosa neon
                textPrimary: "E6F1FF",
                textSecondary: "8892B0"
            )
            
        case .sunsetGlow:
            return PaletteColors(
                bgStart: "1A1A2E",      // Azul escuro base
                bgEnd: "16213E",        // Azul petróleo
                cardStart: "0F3460",    // Azul card
                cardEnd: "533483",      // Roxo card
                accent1: "E94560",      // Rosa/vermelho vibrante
                accent2: "FFB400",      // Amarelo dourado
                textPrimary: "FFFFFF",
                textSecondary: "94A3B8"
            )
        }
    }
}

struct PaletteColors {
    let bgStart: String
    let bgEnd: String
    let cardStart: String
    let cardEnd: String
    let accent1: String
    let accent2: String
    let textPrimary: String
    let textSecondary: String
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Preview Screen
struct RateAllPreview: View {
    // 🎨 MUDE AQUI PARA TESTAR PALETAS
    let palette: ColorPalette = .darkPremium
    // Opções: .darkPremium, .purpleGradient, .blueNeon, .sunsetGlow
    
    @State private var searchText = ""
    
    private var colors: PaletteColors {
        palette.colors
    }
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                colors: [
                    Color(hex: colors.bgStart),
                    Color(hex: colors.bgEnd)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    HStack {
                        Text("RateAll")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color(hex: colors.accent1),
                                        Color(hex: colors.accent2)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(hex: colors.accent1).opacity(0.3),
                                            Color(hex: colors.accent2).opacity(0.3)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 44, height: 44)
                            
                            Image(systemName: "person.circle.fill")
                                .font(.title2)
                                .foregroundStyle(Color(hex: colors.accent2))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color(hex: colors.textSecondary))
                        
                        TextField("Buscar filmes, jogos, animes...", text: $searchText)
                            .foregroundStyle(Color(hex: colors.textPrimary))
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [
                                Color(hex: colors.cardStart).opacity(0.6),
                                Color(hex: colors.cardEnd).opacity(0.6)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color(hex: colors.accent1).opacity(0.3),
                                        Color(hex: colors.accent2).opacity(0.3)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                    .padding(.horizontal)
                    
                    // Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            CategoryChip(icon: "film", title: "Filmes", isSelected: true, colors: colors)
                            CategoryChip(icon: "tv", title: "Séries", isSelected: false, colors: colors)
                            CategoryChip(icon: "gamecontroller", title: "Jogos", isSelected: false, colors: colors)
                            CategoryChip(icon: "sparkles", title: "Animes", isSelected: false, colors: colors)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Stats
                    HStack(spacing: 16) {
                        StatCard(number: "47", label: "Avaliados", colors: colors)
                        StatCard(number: "12", label: "Este mês", colors: colors)
                        StatCard(number: "4.2", label: "Média", colors: colors)
                    }
                    .padding(.horizontal)
                    
                    // Recent Reviews
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Avaliações Recentes")
                            .font(.title3.bold())
                            .foregroundStyle(Color(hex: colors.textPrimary))
                            .padding(.horizontal)
                        
                        MediaCard(
                            title: "Oppenheimer",
                            type: "Filme",
                            rating: 5,
                            comment: "Obra-prima cinematográfica. Nolan no seu melhor.",
                            colors: colors
                        )
                        
                        MediaCard(
                            title: "The Last of Us",
                            type: "Série",
                            rating: 5,
                            comment: "Adaptação perfeita. Emocionante do início ao fim.",
                            colors: colors
                        )
                        
                        MediaCard(
                            title: "Elden Ring",
                            type: "Jogo",
                            rating: 4,
                            comment: "Desafiador e viciante. Mundo incrível.",
                            colors: colors
                        )
                    }
                    
                    Spacer(minLength: 20)
                }
            }
        }
    }
}

// MARK: - Components
struct CategoryChip: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let colors: PaletteColors
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
            Text(title)
                .font(.subheadline.weight(.medium))
        }
        .foregroundStyle(isSelected ? Color(hex: colors.bgStart) : Color(hex: colors.textPrimary))
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            Group {
                if isSelected {
                    LinearGradient(
                        colors: [
                            Color(hex: colors.accent1),
                            Color(hex: colors.accent2)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                } else {
                    LinearGradient(
                        colors: [
                            Color(hex: colors.cardStart).opacity(0.6),
                            Color(hex: colors.cardEnd).opacity(0.6)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
            }
        )
        .cornerRadius(20)
    }
}

struct StatCard: View {
    let number: String
    let label: String
    let colors: PaletteColors
    
    var body: some View {
        VStack(spacing: 4) {
            Text(number)
                .font(.title2.bold())
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(hex: colors.accent1),
                            Color(hex: colors.accent2)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            Text(label)
                .font(.caption)
                .foregroundStyle(Color(hex: colors.textSecondary))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            LinearGradient(
                colors: [
                    Color(hex: colors.cardStart).opacity(0.6),
                    Color(hex: colors.cardEnd).opacity(0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color(hex: colors.accent1).opacity(0.2),
                            Color(hex: colors.accent2).opacity(0.2)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
    }
}

struct MediaCard: View {
    let title: String
    let type: String
    let rating: Int
    let comment: String
    let colors: PaletteColors
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(Color(hex: colors.textPrimary))
                    
                    Text(type)
                        .font(.caption)
                        .foregroundStyle(Color(hex: colors.textSecondary))
                }
                
                Spacer()
                
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < rating ? "star.fill" : "star")
                            .font(.caption)
                            .foregroundStyle(Color(hex: colors.accent1))
                    }
                }
            }
            
            Text(comment)
                .font(.subheadline)
                .foregroundStyle(Color(hex: colors.textSecondary))
                .lineLimit(2)
            
            HStack {
                Spacer()
                
                Button(action: {}) {
                    Text("Ver detalhes")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(hex: colors.accent2),
                                    Color(hex: colors.accent1)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(
            LinearGradient(
                colors: [
                    Color(hex: colors.cardStart).opacity(0.6),
                    Color(hex: colors.cardEnd).opacity(0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color(hex: colors.accent1).opacity(0.2),
                            Color(hex: colors.accent2).opacity(0.2)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
        .padding(.horizontal)
    }
}

// MARK: - Preview
#Preview("Dark Premium") {
    RateAllPreview()
}
