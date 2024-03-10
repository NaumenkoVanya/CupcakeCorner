//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Ваня Науменко on 7.03.24.
//

import SwiftUI

struct CheckoutView: View {
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingAlert = false
    @Environment(\.dismiss) var dismiss

    var order: Order

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text("Failed to place order. Please try again later."), dismissButton: .default(Text("OK")))
                }
            }
        }
        .navigationTitle("Check out")
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .navigationBarTitleDisplayMode(.inline)
        // если нечего прокручивать то не будет это делать
        .scrollBounceBehavior(.basedOnSize)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                })
            }
        }
    }

    func placeOrder() async {
        guard let encoder = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoder)
            let decoderOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "You order for  \(decoderOrder.quantity)x  \(Order.types[decoderOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            showingAlert = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
