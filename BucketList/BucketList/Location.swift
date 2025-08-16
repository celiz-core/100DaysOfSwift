//
//  Location.swift
//  BucketList
//
//  Created by user276992 on 8/15/25.
//

import Foundation
import MapKit

struct Location: Equatable, Codable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    
    #if DEBUG
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "palace place thing", latitude: 51.501, longitude: -0.141)
    #endif
}
