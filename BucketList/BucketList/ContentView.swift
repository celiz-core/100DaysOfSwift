//
//  ContentView.swift
//  BucketList
//
//  Created by user276992 on 8/15/25.
//
import MapKit
import SwiftUI
import LocalAuthentication

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(viewModel.locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                            .onLongPressGesture() {
                                viewModel.selectedPlace = location
                            }
                    }
                }
            }
            .mapStyle(.hybrid)
            .onTapGesture { position in
                if let coord = proxy.convert(position, from: .local) {
                    viewModel.addLocation(at: coord)
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(place) { updatedLocation in
                    viewModel.update(location: updatedLocation)
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
