import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: []
    ) var products: FetchedResults<Product>

    @State private var currentIndex = 0
    
    func seedData() {
        if products.count == 0 {
            for i in 1...10 {
                let newProduct = Product(context: viewContext)
                newProduct.productID = "\(i)"
                newProduct.productName = "Product \(i)"
                newProduct.productDescription = "Description \(i)"
                newProduct.productPrice = Double(i * 10)
                newProduct.productProvider = "Provider \(i)"
            }

            try? viewContext.save()
        }
    }

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
        .onAppear {
            seedData()
        }
        .padding()
    }
}
