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
    
    @State private var credits = 1_000
    @State private var numbers = [
        0, 0, 0,
        0, 0, 0,
        0, 0, 0
    ]
    @State private var symbolBackgrounds = [
        Color.white, Color.white, Color.white,
        Color.white, Color.white, Color.white,
        Color.white, Color.white, Color.white,
    ]
    
    private var betAmount = 5
    @State private var cardsMatchHorizontally = false
    @State private var cardsMatchVertically = false
    @State private var cardsMatchDiagonally = false
    @State private var horizontalMultiplier = 0
    @State private var verticalMultiplier = 0
    @State private var diagonalMultiplier = 0
    

    func horizontalMatch() {
        self.cardsMatchHorizontally = false
        
        if (self.numbers[0] == self.numbers[1] && self.numbers[0] == self.numbers[2]) {
            self.cardsMatchHorizontally = true
            self.horizontalMultiplier += 1
            
            self.symbolBackgrounds[0] = Color.green
            self.symbolBackgrounds[1] = Color.green
            self.symbolBackgrounds[2] = Color.green
        }
        
        if (self.numbers[3] == self.numbers[4] && self.numbers[3] == self.numbers[5]) {
            self.cardsMatchHorizontally = true
            self.horizontalMultiplier += 1
            
            self.symbolBackgrounds[3] = Color.green
            self.symbolBackgrounds[4] = Color.green
            self.symbolBackgrounds[5] = Color.green
        }
        
        if (self.numbers[6] == self.numbers[7] && self.numbers[6] == self.numbers[8]) {
            self.cardsMatchHorizontally = true
            self.horizontalMultiplier += 1
            
            self.symbolBackgrounds[6] = Color.green
            self.symbolBackgrounds[7] = Color.green
            self.symbolBackgrounds[8] = Color.green
        }
    }
    
    func verticalMatch() {
        self.cardsMatchVertically = false
        
        if (self.numbers[0] == self.numbers[3] && self.numbers[0] == self.numbers[6]) {
            self.cardsMatchVertically = true
            self.verticalMultiplier += 1
            
            self.symbolBackgrounds[0] = Color.green
            self.symbolBackgrounds[3] = Color.green
            self.symbolBackgrounds[6] = Color.green
        }
        
        if (self.numbers[1] == self.numbers[4] && self.numbers[1] == self.numbers[7]) {
            self.cardsMatchVertically = true
            self.verticalMultiplier += 1
            
            self.symbolBackgrounds[1] = Color.green
            self.symbolBackgrounds[4] = Color.green
            self.symbolBackgrounds[7] = Color.green
        }
        
        if (self.numbers[2] == self.numbers[5] && self.numbers[2] == self.numbers[8]) {
            self.cardsMatchVertically = true
            self.verticalMultiplier += 1
            
            self.symbolBackgrounds[2] = Color.green
            self.symbolBackgrounds[5] = Color.green
            self.symbolBackgrounds[8] = Color.green
        }
    }
    
    func diagonalMatch() {
        self.cardsMatchDiagonally = false
        
        if (self.numbers[0] == self.numbers[4] && self.numbers[4] == self.numbers[8]) {
            self.cardsMatchDiagonally = true
            self.diagonalMultiplier += 1
            
            self.symbolBackgrounds[0] = Color.green
            self.symbolBackgrounds[4] = Color.green
            self.symbolBackgrounds[8] = Color.green
        }
        if (self.numbers[2] == self.numbers[4] && self.numbers[4] == self.numbers[6]) {
            self.cardsMatchDiagonally = true
            self.diagonalMultiplier += 1
            
            self.symbolBackgrounds[2] = Color.green
            self.symbolBackgrounds[4] = Color.green
            self.symbolBackgrounds[6] = Color.green
        }
    }
    
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
                        .foregroundColor(.yellow).padding(20).scaleEffect(2)
                    
                    Text("Play The Slots")
                        .font(.largeTitle).fontWeight(.semibold).foregroundColor(.white)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow).padding(20).scaleEffect(2)
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
                            symbolBackground: $symbolBackgrounds[0]
                        )
                        CardView(
                            symbol: $symbols[numbers[1]],
                            symbolBackground: $symbolBackgrounds[1]
                        )
                        CardView(
                            symbol: $symbols[numbers[2]],
                            symbolBackground: $symbolBackgrounds[2]
                        )
                       
                        Spacer()
                    }
                    HStack {
                        CardView(
                            symbol: $symbols[numbers[3]],
                            symbolBackground: $symbolBackgrounds[3]
                        )
                        CardView(
                            symbol: $symbols[numbers[4]],
                            symbolBackground: $symbolBackgrounds[4]
                        )
                        CardView(
                            symbol: $symbols[numbers[5]],
                            symbolBackground: $symbolBackgrounds[5]
                        )
                    }
                    HStack {
                         CardView(
                             symbol: $symbols[numbers[6]],
                             symbolBackground: $symbolBackgrounds[6]
                         )
                         CardView(
                             symbol: $symbols[numbers[7]],
                             symbolBackground: $symbolBackgrounds[7]
                         )
                         CardView(
                             symbol: $symbols[numbers[8]],
                             symbolBackground: $symbolBackgrounds[8]
                         )
                     }
                    .padding(.bottom, 40)
                }
                
                Spacer()
                
                Button(action: {
                    self.numbers = self.numbers.map({ _ in
                        Int.random(in: 0..<self.symbols.count)
                    })
                    
                    self.horizontalMultiplier = 0
                    self.verticalMultiplier = 0
                    self.diagonalMultiplier = 0
                    
                    // set card backgrounds back to white
                    self.symbolBackgrounds = self.symbolBackgrounds.map { _ in
                        Color.white
                    }
                    
                    self.horizontalMatch()
                    self.verticalMatch()
                    self.diagonalMatch()
                    
                    let multipliers = self.verticalMultiplier + self.horizontalMultiplier + self.diagonalMultiplier
                    
                    if (self.cardsMatchVertically && self.cardsMatchHorizontally && self.cardsMatchDiagonally) {
                        self.credits += self.betAmount * 10 * multipliers
                       print("V + H + D = \(self.credits) | m : \(multipliers)")
                    }
                    else if (self.cardsMatchVertically && self.cardsMatchHorizontally) {
                        self.credits += self.betAmount * 20 * multipliers
                        print("V + H = \(self.credits) | m : \(multipliers)")
                    }
                    else if (self.cardsMatchVertically && self.cardsMatchDiagonally) {
                        self.credits += self.betAmount * 20 * multipliers
                        print("V + D = \(self.credits) | m : \(multipliers)")
                    }
                    else if (self.cardsMatchHorizontally && self.cardsMatchDiagonally) {
                        self.credits += self.betAmount * 20 * multipliers
                        print("H + D = \(self.credits) | m : \(multipliers)")
                    }
                    else if (self.cardsMatchDiagonally) {
                        self.credits += self.betAmount * 15 * multipliers
                        print("D = \(self.credits) | m : \(multipliers)")
                    }
                    else if (self.cardsMatchHorizontally) {
                        self.credits += self.betAmount * 10 * multipliers
                        print("H = \(self.credits) | m : \(multipliers)")
                    }
                    else if (self.cardsMatchVertically) {
                        self.credits += self.betAmount * 10 * multipliers
                        print("V = \(self.credits) | m : \(multipliers)")
                    }
                    else {
                        print("no match: \(self.credits)")
                        self.credits -= self.betAmount
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
