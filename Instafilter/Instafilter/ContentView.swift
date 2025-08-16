//
//  ContentView.swift
//  Instafilter
//
//  Created by user276992 on 8/13/25.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
import PhotosUI
import StoreKit

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    @State private var showingFilters = false
    
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture selected", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }.onChange(of: selectedItem, loadImage)
            
                Spacer()
                
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                }.onChange(of: filterIntensity, applyProcessing)
                
                HStack {
                    Button("Change filter", action: changeFilter)
                    Spacer()
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }.onChange(of: currentFilter, loadImage)
            }
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallization") {setFilter(CIFilter.crystallize())}
                Button("Edges") {setFilter(CIFilter.edges())}
                Button("Sepia Tone") {setFilter(CIFilter.sepiaTone())}
                Button("Vignette") {setFilter(CIFilter.vignette())}
                Button("Cancel", role: .cancel) {}
            }
        }
        .padding()
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
    }
    
    func applyProcessing() {
        
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else {return}
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else{ return }
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
        
    }
    
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {return }
            
            guard let inputImage = UIImage(data: imageData) else {return}
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
            
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
}

#Preview {
    ContentView()
}
