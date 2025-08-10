//
//  AddView.swift
//  iExpense
//
//  Created by user276992 on 8/9/25.
//

import SwiftUI

let types = ["Business", "Personal"]


struct AddView: View {
    @State private var name = ""
    @State private var type = types[0]
    
    
    @Environment(\.dismiss) var dismiss
    
    var expenses: Expenses
    
    @State private var amount = 0.0
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add Expense")
            .toolbar {
                Button("Save") {
                    expenses.items.append(ExpenseItem(name: name, type: type, amount: amount))
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
