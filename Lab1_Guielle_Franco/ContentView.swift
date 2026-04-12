//
//  ContentView.swift
//  Lab1_Guielle_Franco
//
//  Created by Guielle Mikhailavich Yre Franco on 2026-04-11.
//

import SwiftUI

struct ContentView: View {
    @State private var currentNumber: Int = Int.random(in: 1...100)
    @State private var correctAnswers: Int = 0
    @State private var wrongAnswers: Int = 0
    @State private var totalAttempts: Int = 0
    @State private var feedbackSymbol: String = ""
    @State private var feedbackColor: Color = .clear
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("\(currentNumber)")
                .font(.system(size: 64, weight: .light, design: .serif))
                .foregroundColor(.mint)
            
            Button("Prime") {
            }
            .font(.title2)
            .foregroundColor(.mint)
            
            Button("Not Prime") {
            }
            .font(.title2)
            .foregroundColor(.mint)
            
            Text(feedbackSymbol)
                .font(.system(size: 90, weight: .bold))
                .foregroundColor(feedbackColor)
                .frame(height: 120)
            
            Spacer()
            
            HStack {
                Text("Correct: \(correctAnswers)")
                Spacer()
                Text("Wrong: \(wrongAnswers)")
            }
            .padding(.horizontal)
            .font(.headline)
            
            Text("Attempts: \(totalAttempts)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
