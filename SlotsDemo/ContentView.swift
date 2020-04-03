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
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var symbolBackgrounds = Array(repeating: Color.white, count: 9)
    @State private var matches = 0
    
    private var betAmount = 10
    
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
                
                HStack {
                    Spacer()
                    Button(action: {
                        // Do a single spin
                        self.processResults()
                        
                    }) {
                        Text("\(betAmount) Credits")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .padding([.leading, .trailing], 20)
                            .background(Color.orange.opacity(20))
                            .cornerRadius(15)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Spin all
                        self.processResults(true)
                        
                    }) {
                        Text("\(betAmount * 10) Credits")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .padding([.leading, .trailing], 20)
                            .background(Color.pink)
                            .cornerRadius(15)
                        
                    }
                    Spacer()
                }
                
                Spacer()
            }
        }
        
    }
    
    func horizontalMatch() {
        checkMatch(0, 1, 2)
        checkMatch(3, 4, 5)
        checkMatch(6, 7, 8)
    }
    
    func verticalMatch() {
        checkMatch(0, 3, 6)
        checkMatch(1, 4, 7)
        checkMatch(2, 5, 8)
    }
    
    func diagonalMatch() {
        checkMatch(0, 4, 8)
        checkMatch(2, 4, 6)
    }
    
    func processResults(_ isMax: Bool = false) {
        // set card backgrounds back to white
        self.symbolBackgrounds = self.symbolBackgrounds.map { _ in
            Color.white
        }
        
    
        if isMax {
            // Spin all the cards
            // change the images
            self.numbers = self.numbers.map({ _ in
                Int.random(in: 0..<self.symbols.count)
            })
        }
        else {
            // Spin the middle row
            self.numbers[3] = Int.random(in: 0..<self.symbols.count)
            self.numbers[4] = Int.random(in: 0..<self.symbols.count)
            self.numbers[5] = Int.random(in: 0..<self.symbols.count)
        }
        
        processWin(isMax)
    }
    
    func processWin(_ isMax: Bool = false) {
        self.matches = 0
        
        if !isMax {
            // only the middle row
            checkMatch(3, 4, 5)
        }
        else {
            // Processing for max spin
            horizontalMatch()
            verticalMatch()
            diagonalMatch()
        }
        
        // Check matches and calculate credits
        if self.matches > 0 {
            // wins
            self.credits += self.matches * betAmount * 2
        }
        else if !isMax {
            // 0 wins, single spin
            self.credits -= betAmount
        }
        else {
            // 0 wins, max spin
            self.credits -= betAmount * 6
        }
    }
    
    func checkMatch(_ index1:Int, _ index2: Int, _ index3: Int) {
        if (self.numbers[index1] == self.numbers[index2] && self.numbers[index2] == self.numbers[index3]) {
            self.symbolBackgrounds[index1] = Color.green
            self.symbolBackgrounds[index2] = Color.green
            self.symbolBackgrounds[index3] = Color.green
            
            self.matches += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
