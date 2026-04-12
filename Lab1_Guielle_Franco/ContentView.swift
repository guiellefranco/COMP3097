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
        VStack {
            Text("Prime Number Game")
            Text("\(currentNumber)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
