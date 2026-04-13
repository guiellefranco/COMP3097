//
//  AddProductView.swift
//  A2_iOS_Guielle_101364236
//
//  Created by Guielle Mikhailavich Yre Franco on 2026-04-12.
//

import SwiftUI
import CoreData

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var productID = ""
    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productPrice = ""
    @State private var productProvider = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Information")) {
                    TextField("Product ID", text: $productID)
                    TextField("Product Name", text: $productName)
                    TextField("Product Description", text: $productDescription)
                    TextField("Product Price", text: $productPrice)
                        .keyboardType(.decimalPad)
                    TextField("Product Provider", text: $productProvider)
                }
            }
            .navigationTitle("Add Product")
            .alert("Invalid Input", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveProduct()
                    }
                }
            }
        }
    }

    private func saveProduct() {
        if productID.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            productName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            productDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            productPrice.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            productProvider.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }
        
        guard let price = Double(productPrice) else {
            alertMessage = "Please enter a valid price."
            showAlert = true
            return
        }

        let newProduct = Product(context: viewContext)
        newProduct.productID = productID
        newProduct.productName = productName
        newProduct.productDescription = productDescription
        newProduct.productPrice = price
        newProduct.productProvider = productProvider

        do {
            try viewContext.save()
            dismiss()
        } catch {
            alertMessage = "Error saving product."
            showAlert = true
        }
    }
}
