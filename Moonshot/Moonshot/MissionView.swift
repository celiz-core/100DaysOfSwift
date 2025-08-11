//
//  MissionView.swift
//  Moonshot
//
//  Created by user276992 on 8/11/25.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView() {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                Text(mission.formattedDate)
                    .font(.subheadline)
                    .padding()
                
                VStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.blue)
                        .padding(.vertical)
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.blue)
                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.title.bold())
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { member in
                                AstronautCard(crewMember: member)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing JSON Data!")
            }
        }
    }
}


#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronaunts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return NavigationStack {
        MissionView(mission: missions[0], astronauts: astronaunts)
            .preferredColorScheme(.dark)
    }
}
