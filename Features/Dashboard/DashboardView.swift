//
//  DashboardView.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 12/12/25.
//

import Foundation
import SwiftUI

struct DashboardView: View {
    var body: some View {
        ZStack{

            VStack(spacing: -62){
                TopbarView()
                NavBarView()
            }
        }
    }
}

#Preview {
    DashboardView()
}
