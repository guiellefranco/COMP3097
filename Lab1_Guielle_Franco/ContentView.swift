import SwiftUI
internal import Combine

struct ContentView: View {
    
    // current number shown on screen
    @State private var currentNumber: Int = Int.random(in: 1...100)
    
    // score tracking
    @State private var correctAnswers: Int = 0
    @State private var wrongAnswers: Int = 0
    @State private var totalAttempts: Int = 0
    
    // used to show check or cross after answering
    @State private var feedbackSymbol: String = ""
    @State private var feedbackColor: Color = .clear
    
    // controls result popup after 10 tries
    @State private var showResultDialog: Bool = false
    
    // prevents user from answering multiple times
    @State private var hasAnsweredCurrentQuestion: Bool = false
    
    // stops timer from running while waiting for next question
    @State private var isWaitingForNextQuestion: Bool = false
    
    // countdown timer (starts at 5 seconds)
    @State private var timeRemaining: Int = 5
    
    // timer runs every 1 second so we can show countdown
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 30) {
            
            Spacer()
            
            // shows the number to guess
            Text("\(currentNumber)")
                .font(.system(size: 64, weight: .light, design: .serif))
                .foregroundColor(.mint)
            
            // countdown display
            Text("Time left: \(timeRemaining)")
                .font(.title3)
                .foregroundColor(.orange)
            
            // button for prime answer
            Button(action: {
                checkAnswer(userSaysPrime: true)
            }) {
                Text("Prime")
                    .font(.title2)
                    .foregroundColor(.mint)
            }
            // disable button after answer or during delay
            .disabled(hasAnsweredCurrentQuestion || isWaitingForNextQuestion)
            
            // button for not prime answer
            Button(action: {
                checkAnswer(userSaysPrime: false)
            }) {
                Text("Not Prime")
                    .font(.title2)
                    .foregroundColor(.mint)
            }
            .disabled(hasAnsweredCurrentQuestion || isWaitingForNextQuestion)
            
            // shows ✔ or ✘ after answering
            Text(feedbackSymbol)
                .font(.system(size: 90, weight: .bold))
                .foregroundColor(feedbackColor)
                .frame(height: 120)
            
            Spacer()
            
            // score display
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
        
        // popup after every 10 attempts
        .alert("Results after 10 attempts", isPresented: $showResultDialog) {
            Button("Continue") {
                generateNewNumber()
            }
        } message: {
            Text("Correct answers: \(correctAnswers)\nWrong answers: \(wrongAnswers)")
        }
        
        // timer updates every second
        .onReceive(timer) { _ in
            handleTimerTick()
        }
    }
    
    // checks if user's answer matches actual result
    func checkAnswer(userSaysPrime: Bool) {
        // stop if already answered or waiting
        guard !hasAnsweredCurrentQuestion && !isWaitingForNextQuestion else { return }
        
        hasAnsweredCurrentQuestion = true
        isWaitingForNextQuestion = true
        
        let actualPrime = isPrime(currentNumber)
        
        // compare user answer with actual result
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
        handleAttemptCompletion()
    }
    
    // handles countdown and timeout logic
    func handleTimerTick() {
        // don't run if waiting for next question
        guard !isWaitingForNextQuestion else { return }
        
        if timeRemaining > 1 {
            timeRemaining -= 1
        } else {
            // time ran out → count as wrong
            if !hasAnsweredCurrentQuestion {
                wrongAnswers += 1
                totalAttempts += 1
                feedbackSymbol = "✘"
                feedbackColor = .red
                isWaitingForNextQuestion = true
                handleAttemptCompletion()
            }
        }
    }
    
    // runs after each attempt
    func handleAttemptCompletion() {
        // show dialog every 10 attempts
        if totalAttempts % 10 == 0 {
            showResultDialog = true
        } else {
            // small delay before next number
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                generateNewNumber()
            }
        }
    }
    
    // resets everything for next question
    func generateNewNumber() {
        currentNumber = Int.random(in: 1...100)
        feedbackSymbol = ""
        feedbackColor = .clear
        hasAnsweredCurrentQuestion = false
        isWaitingForNextQuestion = false
        timeRemaining = 5
    }
    
    // function to check if number is prime
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
}

#Preview {
    ContentView()
}
