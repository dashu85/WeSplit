//
//  ContentView.swift
//  WeSplit
//
//  Created by Marcus Benoit on 06.03.24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [5, 10, 15, 20, 0]
    
    // total amount every guest has to pay: bill + tip divided amount of users
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = tipValue + checkAmount
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    // total amount users have to pay: bill + tip
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = tipValue + checkAmount
        
        return grandTotal
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                // Picker section with a fixed array of percentages
//                Section("How much tip do you want to leave?") {
//                    Picker("Tip Percentage", selection: $tipPercentage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
                
                // Solution to challenge 3
                Section("How much tip do you want to leave?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                // How many people want to split the check?
                Picker("Number of People", selection: $numberOfPeople) {
                    ForEach(2..<20) {
                        Text("\($0) people")
                    }
                } // Picker
                .pickerStyle(.navigationLink) // shows the options on a new side
                
                Section("Total Amount:") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
                
                // Presenting the amount everybody has to pay
                Section("Everybody has to pay") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
            } // Form
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            } // toolbar for the Done button to dismiss the .decimalPad
        } // NavigationStack
    } // body
} // ContentView

#Preview {
    ContentView()
}
