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
        let newProduct = Product(context: viewContext)
        newProduct.productID = productID
        newProduct.productName = productName
        newProduct.productDescription = productDescription
        newProduct.productPrice = Double(productPrice) ?? 0.0
        newProduct.productProvider = productProvider

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Error saving product: \(error.localizedDescription)")
        }
    }
}
