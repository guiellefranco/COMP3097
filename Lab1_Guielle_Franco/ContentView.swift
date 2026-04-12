//
//  ContentView.swift
//  Lab1_Guielle_Franco
//
//  Created by Guielle Mikhailavich Yre Franco on 2026-04-11.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentNumber: Int = Int.random(in: 1...100)
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Prime Number Game")
            
            Text("\(currentNumber)")
                .font(.system(size: 64, weight: .light, design: .serif))
                .foregroundColor(.mint)
            
            Button("Prime") {
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
