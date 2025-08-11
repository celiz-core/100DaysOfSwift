//
//  AstronautCard.swift
//  Moonshot
//
//  Created by user276992 on 8/11/25.
//
import SwiftUI


struct AstronautCard: View {
    let crewMember: CrewMember
    
    var body: some View {
        NavigationLink {
            AstronautView(astronaut: crewMember.astronaut)
        } label: {
            HStack {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .frame(width: 104, height: 72)
                    .clipShape(.capsule)
                    .overlay {
                        Capsule()
                            .strokeBorder(.white, lineWidth: 1)
                    }
                VStack(alignment: .leading) {
                    Text(crewMember.astronaut.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text("Role: \(crewMember.role)")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            .padding(.horizontal)
        }
    }
}



#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    
    guard let randomAstronaut = astronauts.randomElement()?.value else {
        fatalError("Could not find random astro")
    }
    
    let mockCrewMember = CrewMember(role: "Mock role", astronaut: randomAstronaut)
    
    return NavigationStack {
        AstronautCard(crewMember: mockCrewMember)
    }
    .preferredColorScheme(.dark)
}
