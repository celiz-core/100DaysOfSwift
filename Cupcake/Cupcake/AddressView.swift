//
//  AddressView.swift
//  Cupcake
//
//  Created by user276992 on 8/12/25.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("ZIP code", text: $order.zip)
            }
            
            Section {
                NavigationLink("Checkout") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Address")
    }
}

#Preview {
    NavigationStack {
        AddressView(order: Order())
    }
}
