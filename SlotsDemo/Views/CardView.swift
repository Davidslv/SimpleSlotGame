//
//  CardView.swift
//  SlotsDemo
//
//  Created by David Silva on 02/04/2020.
//  Copyright © 2020 David Silva. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @Binding var symbol: String
    @Binding var symbolBackground: Color
    
    var body: some View {
        Image(symbol)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .background(symbolBackground.opacity(0.5))
            .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(symbol: Binding.constant("cherry"), symbolBackground: Binding.constant(Color.green))
    }
}
