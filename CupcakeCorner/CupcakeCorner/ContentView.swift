//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ваня Науменко on 7.03.24.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Selection your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    .pickerStyle(.menu)
                    Spacer()
                    Stepper("Number of cakes  \(order.quantity)", value: $order.quantity, in: 3 ... 20)
                }
                Section {
                    Toggle("Any special requests ?", isOn: $order.specialRequestEnabled)
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting ?", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles ?", isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(order: Order())
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
        Image("image")
            .resizable()
            .ignoresSafeArea()
            .scaledToFit()
    }
}

#Preview {
    ContentView()
}
