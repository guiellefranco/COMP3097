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
    @State private var hasAnsweredCurrentQuestion: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("\(currentNumber)")
                .font(.system(size: 64, weight: .light, design: .serif))
                .foregroundColor(.mint)
            
            Button("Prime") {
                checkAnswer(userSaysPrime: true)
            }
            .font(.title2)
            .foregroundColor(.mint)
            
            Button("Not Prime") {
                checkAnswer(userSaysPrime: false)
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
    
    func isPrime(_ number: Int) -> Bool {
        if number < 2 { return false }
        if number == 2 { return true }
        if number % 2 == 0 { return false }
        
        let maxDivisor = Int(Double(number).squareRoot())
        if maxDivisor >= 3 {
            for i in stride(from: 3, through: maxDivisor, by: 2) {
                if number % i == 0 {
                    return false
                }
            }
        }
        
        return true
    }
    
    func checkAnswer(userSaysPrime: Bool) {
        guard !hasAnsweredCurrentQuestion else { return }
        
        hasAnsweredCurrentQuestion = true
        
        let actualPrime = isPrime(currentNumber)
        
        if userSaysPrime == actualPrime {
            correctAnswers += 1
            feedbackSymbol = "✔"
            feedbackColor = .green
        } else {
            wrongAnswers += 1
            feedbackSymbol = "✘"
            feedbackColor = .red
        }
        
        totalAttempts += 1
    }
    
    func generateNewNumber() {
        currentNumber = Int.random(in: 1...100)
        feedbackSymbol = ""
        feedbackColor = .clear
        hasAnsweredCurrentQuestion = false
    }
}

#Preview {
    ContentView()
}
