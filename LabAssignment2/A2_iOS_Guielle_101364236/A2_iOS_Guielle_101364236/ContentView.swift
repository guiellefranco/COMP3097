import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: []
    ) var products: FetchedResults<Product>

    @State private var currentIndex = 0

    var body: some View {
        VStack(spacing: 20) {
            
            if products.count > 0 {
                let product = products[currentIndex]

                Text(product.productName ?? "No Name")
                    .font(.title)

                Text(product.productDescription ?? "No Description")

                Text("$\(product.productPrice)")
                    .font(.headline)

                Text(product.productProvider ?? "")
                    .font(.subheadline)
            } else {
                Text("No Products Available")
            }

            HStack {
                Button("Previous") {
                    if currentIndex > 0 {
                        currentIndex -= 1
                    }
                }

                Button("Next") {
                    if currentIndex < products.count - 1 {
                        currentIndex += 1
                    }
                }
            }
        }
        .padding()
    }
}
