//
//  ContentView.swift
//  SlotsDemo
//
//  Created by David Silva on 02/04/2020.
//  Copyright © 2020 David Silva. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var symbols = ["apple", "cherry", "star"]
    @State private var symbolBackground = Color.white
    @State private var credits = 1_000
    @State private var numbers = [
        0, 0, 0,
        0, 0, 0,
        0, 0, 0,
    ]
    @State private var won = false
    private var betAmount = 5
    
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(
                    Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(
                    Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45 ))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .padding(20)
                        .scaleEffect(2)
                    
                    Text("Play The Slots")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .padding(20)
                        .scaleEffect(2)
                }
                Spacer()
                
                
                Text("Credits: \(credits)")
                    .foregroundColor(.black)
                    .padding(10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                Spacer()
                
                
                VStack {
                    HStack {
                        Spacer()
                        
                        CardView(
                            symbol: $symbols[numbers[0]],
                            symbolBackground: $symbolBackground
                        )
                        CardView(
                            symbol: $symbols[numbers[1]],
                            symbolBackground: $symbolBackground
                        )
                        CardView(
                            symbol: $symbols[numbers[2]],
                            symbolBackground: $symbolBackground
                        )
                       
                        Spacer()
                    }
                    HStack {
                        CardView(
                            symbol: $symbols[numbers[3]],
                            symbolBackground: $symbolBackground
                        )
                        CardView(
                            symbol: $symbols[numbers[4]],
                            symbolBackground: $symbolBackground
                        )
                        CardView(
                            symbol: $symbols[numbers[5]],
                            symbolBackground: $symbolBackground
                        )
                    }
                    HStack {
                         CardView(
                             symbol: $symbols[numbers[6]],
                             symbolBackground: $symbolBackground
                         )
                         CardView(
                             symbol: $symbols[numbers[7]],
                             symbolBackground: $symbolBackground
                         )
                         CardView(
                             symbol: $symbols[numbers[8]],
                             symbolBackground: $symbolBackground
                         )
                     }
                    .padding(.bottom, 40)
                }
                
                Spacer()
                
                Button(action: {
                    self.numbers = self.numbers.map({ _ in
                        Int.random(in: 0...self.symbols.count - 1)
                    })
                    
                    if (self.numbers[0] == self.numbers[1] && self.numbers[0] == self.numbers[2]) {
                        self.credits += self.betAmount * 10
                        self.symbolBackground = Color.green
                        self.won = true
                    }
                    else {
                        self.credits -= self.betAmount
                        self.symbolBackground = Color.white
                        self.won = false
                    }
                    
                }) {
                    Text("Spin")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.all, 10)
                        .padding([.leading, .trailing], 30)
                        .background(Color.pink)
                        .cornerRadius(15)
                    
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
