import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(key: "productName", ascending: true)]
    )
    private var products: FetchedResults<Product>

    @State private var currentIndex: Int = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if products.isEmpty {
                    Text("No Products Available")
                        .font(.title2)
                        .foregroundColor(.gray)
                } else {
                    productDetailView
                    navigationButtons
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Product Viewer")
            .onAppear {
                seedData()
            }
        }
    }

    private var safeIndex: Int {
        min(currentIndex, max(products.count - 1, 0))
    }

    private var currentProduct: Product? {
        guard !products.isEmpty else { return nil }
        return products[safeIndex]
    }

    private var productDetailView: some View {
        Group {
            if let product = currentProduct {
                VStack(spacing: 12) {
                    Text(product.productName ?? "No Name")
                        .font(.largeTitle)
                        .bold()

                    Text("Product ID: \(product.productID ?? "")")
                        .font(.headline)

                    Text(product.productDescription ?? "No Description")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Text(String(format: "Price: $%.2f", product.productPrice))
                        .font(.title3)

                    Text("Provider: \(product.productProvider ?? "")")
                        .foregroundColor(.gray)
                }
            }
        }
    }

    private var navigationButtons: some View {
        HStack(spacing: 20) {
            Button("Previous") {
                if currentIndex > 0 {
                    currentIndex -= 1
                }
            }
            .disabled(currentIndex == 0)

            Button("Next") {
                if currentIndex < products.count - 1 {
                    currentIndex += 1
                }
            }
            .disabled(currentIndex >= products.count - 1)
        }
        .padding(.top)
    }

    private func seedData() {
        if products.isEmpty {
            let sampleProducts: [(String, String, String, Double, String)] = [
                ("P001", "Laptop", "15-inch laptop with 16GB RAM", 999.99, "Tech World"),
                ("P002", "Mouse", "Wireless ergonomic mouse", 29.99, "LogiTech"),
                ("P003", "Keyboard", "Mechanical keyboard with backlight", 79.99, "KeyPro"),
                ("P004", "Monitor", "24-inch Full HD monitor", 189.99, "ViewMax"),
                ("P005", "Phone", "128GB smartphone with OLED display", 799.99, "MobileHub"),
                ("P006", "Tablet", "10-inch tablet for media and work", 399.99, "TabZone"),
                ("P007", "Headphones", "Noise-cancelling headphones", 149.99, "SoundLab"),
                ("P008", "Printer", "Wireless all-in-one printer", 129.99, "PrintEase"),
                ("P009", "Speaker", "Portable Bluetooth speaker", 59.99, "AudioGo"),
                ("P010", "Webcam", "HD webcam for video calls", 49.99, "CamTech")
            ]

            for item in sampleProducts {
                let newProduct = Product(context: viewContext)
                newProduct.productID = item.0
                newProduct.productName = item.1
                newProduct.productDescription = item.2
                newProduct.productPrice = item.3
                newProduct.productProvider = item.4
            }

            do {
                try viewContext.save()
            } catch {
                print("Error saving sample products: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
