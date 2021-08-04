//
//  MainView.swift
//  TipsMe
//
//  Created by Максим Соловьёв on 04.08.2021.
//

import SwiftUI

struct MainView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @State private var typeCurrency = "RUB"
    
    let tipPercentages = [5, 10, 15, 20]
    let typesCurrency = ["RUB", "USA", "EURO"]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Общая сумма по чеку")) {
                    TextField("Сколько сколько ???", text: $checkAmount)
                }
                
                Section(header: Text("Общее количество людей")) {
                    Picker("Количество людей", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section(header: Text("Процент чаевых")) {
                    Picker("", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Валюта")) {
                    Picker("", selection: $typeCurrency) {
                        ForEach(typesCurrency, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Итого с каждого скидываемся по ...")) {
                    Text("\(totalPerPerson, specifier: "%.2f") \(typeCurrency)")
                }
                
            }
            .navigationBarTitle("TipsMe", displayMode: .large)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
