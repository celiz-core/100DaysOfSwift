//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by user276992 on 8/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var roundNum = 1
    
    @State var roundOver = false
    
    //For animations
    @State private var tappedFlagIndex: Int? = nil
    
    func flagTapped(_ number: Int) {
        
        tappedFlagIndex = number
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])"
            score -= 1
        }
        showingScore = true
        roundNum += 1
        roundOver = roundNum == 9
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
    func resetGame() {
        score = 0
        roundNum = 1
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack (spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label : {
                            Image(countries[number])
                                .shadow(radius: 5)
                        }.scale((tappedFlagIndex ?? -1) == number ? 0.5 : 1)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is: \(score)")
        }
        .alert("Game over", isPresented: $roundOver) {
            Button("Continue", action: resetGame)
        } message: {
            Text("Score: \(score)")
        }
    }
}

#Preview {
    ContentView()
}
