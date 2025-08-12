//
//  CheckoutView.swift
//  Cupcake
//
//  Created by user276992 on 8/12/25.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMsg = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                           scale: 3) {phase in
                    switch phase {
                    case .success(let img):
                        img
                            .resizable()
                            .scaledToFit()
                    default :
                        EmptyView()
                    }
                }
                           .frame(height: 223)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMsg)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode")
            return
        }
        
        let url = URL(string: "https://regres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        //Note: The api domain no longer exists! Replaced HTTP request/reponse with placeholder logic
        confirmationMsg = "Your order for \(order.quantity) \(Order.types[order.type]) cupcakes is on the way!"
        showingConfirmation = true
        
        //do {
        //    let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
        //
        //    let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
        //
        //    confirmationMsg = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type]) is on the way!"
        //    showingConfirmation = true
        //} catch {
        //
        //confirmationMsg = "Checkout failed!"
        //    showingConfirmation = true
        //    print("\(error)")
        //}
    }
}


#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
