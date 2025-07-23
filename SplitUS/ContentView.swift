//
//  ContentView.swift
//  SplitUS
//
//  Created by Miguel Angel Bohorquez on 11/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    let tipPercentages = [0,  15, 20, 25]
    @State private var tipPercentage = 20
    @State private var numberPeople = 2
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson : Double {
        let peopleCount =   Double(numberPeople + 2)
        let tipSelection =  Double(tipPercentage) 
        let tipValue = checkAmount * (tipSelection / 100)
        let grandTotal = checkAmount + tipValue
        let totalPerPersonValue = grandTotal / peopleCount
        
        return totalPerPersonValue
    }
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.blue.edgesIgnoringSafeArea(.all).opacity(0.3)
                VStack{
                    Form{

                        Section(header: Text("Check Amount")) {
                            TextField("Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            
                                .keyboardType(.decimalPad) .focused($amountIsFocused)
                            Picker("Number of people", selection: $numberPeople){
                                ForEach(2..<100){
                                    Text("\($0) people")
                                }
                            }
                            
                        }
                        Section(header: Text("How much do you wanr to tip?")) {
                            Picker("Tip percentaje", selection: $tipPercentage){
                                ForEach(tipPercentages, id: \.self){
                                    Text("\($0) %  ")
                                }
                            }.pickerStyle(.segmented)
                        }
                        
                        Section{
                            
                            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).bold()
                        }
                        
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("We Split")
                .toolbar{
                    if amountIsFocused {
                        Button("Done"){
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
