//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by user276992 on 8/16/25.
//


import MapKit
import SwiftUI
import CoreLocation

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "Name", description: "", latitude: point.latitude, longitude: point.longitude)
            self.locations.append(newLocation)
            self.selectedPlace = newLocation
            save()
        }
        
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = self.locations.firstIndex(of: selectedPlace) {
                self.locations[index] = location
            }
            save()
        }
        
        
        init () {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("unable to save data")
            }
        }
    }
}
