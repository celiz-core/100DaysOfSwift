//
//  ContentView.swift
//  Cupcake
//
//  Created by user276992 on 8/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) { i in
                            Text(Order.types[i])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                    
                }
                
                
                Section {
                    NavigationLink("Delivery Details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
    
}

#Preview {
    ContentView()
}
