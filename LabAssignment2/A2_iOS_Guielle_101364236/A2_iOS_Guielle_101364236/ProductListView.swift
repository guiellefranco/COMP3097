//
//  ProductListView.swift
//  A2_iOS_Guielle_101364236
//
//  Created by Guielle Mikhailavich Yre Franco on 2026-04-12.
//

import SwiftUI

struct ProductListView: View {
    let products: [Product]

    var body: some View {
        NavigationView {
            List(products, id: \.objectID) { product in
                VStack(alignment: .leading, spacing: 6) {
                    Text(product.productName ?? "No Name")
                        .font(.headline)

                    Text(product.productDescription ?? "No Description")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("All Products")
        }
    }
}
