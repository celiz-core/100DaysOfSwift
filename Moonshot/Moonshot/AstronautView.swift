//
//  AstronautView.swift
//  Moonshot
//
//  Created by user276992 on 8/11/25.
//

import SwiftUI


struct AstronautView: View {
    let astronaut: Astronaut
    
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .padding()
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    guard let randomAstronaut = astronauts.randomElement()?.value else {
        fatalError("could not load random astronaut")
    }
    
    return NavigationStack {
        AstronautView(astronaut: randomAstronaut)
            .preferredColorScheme(.dark)
    }
}
