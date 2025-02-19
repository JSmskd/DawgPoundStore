import SwiftUI

struct FavoritesView: View {
    // Sample Product Data
    var model:StateObject<ItemViewModel>
    init (_ model:StateObject<ItemViewModel>) {
        self.model = model
        //        trendingItems = []//model.wrappedValue.getTasks()
        model.wrappedValue.getTasks()
    }

//    @State private var products = [
//        Product(name: "Nike Hersey Classic Hoodie", price: "$55", isFavorite: true),
//        Product(name: "Nike Hersey Beanie", price: "$15"),
//        Product(name: "Gildan Hersey Classic Sweatpants", price: "$25", isFavorite: false),
//        Product(name: "Gildan Hersey Classic Sweatshirt", price: "$35"),
//        Product(name: "Nike Hersey Classic Hoodie", price: "$55"),
//        Product(name: "Nike Hersey Beanie", price: "$15"),
//        Product(name: "Gildan Hersey Classic Sweatpants", price: "$25"),
//        Product(name: "Gildan Hersey Classic Sweatshirt", price: "$35")
//    ]

    // Dynamic Grid Layout
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            // Back Button and Title
            HStack {
                Button(action: {
                    print("Back button tapped")
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.title)
                }
                Spacer()
                Text("DAWG POUND")
                    .font(.custom("Lexend-Bold", size: 28))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)

            // Favorites Title
            Text("My Favorites")
                .font(.custom("Lexend-Regular", size: 24))
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top, 10)

            // Product Grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
//                    ForEach($products) { $product in
//                        ProductView(product: $product)
//                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

// Product Model
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: String
    var isFavorite: Bool = false
}

// Single Product Card View
struct ProductView: View {
    @Binding var product: Product
    let cardHeight: CGFloat = 180

    var body: some View {
        VStack(spacing: 0) {
            // Product Image Placeholder with Favorite Button
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: cardHeight)
                .overlay(
                    Button(action: {
                        product.isFavorite.toggle()
                        print("\(product.name) favorite status: \(product.isFavorite)")
                    }) {
                        Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .medium))
                            .padding(8)
                    },
                    alignment: .topTrailing
                )

            // Product Info
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.custom("Lexend-Regular", size: 16))
                    .foregroundColor(.white)
                Text(product.price)
                    .font(.custom("Lexend-Bold", size: 16))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 8)
            .padding(.top, 4)

            // "Move to Cart" Button
            Button(action: {
                moveToCart()
            }) {
                Text("Move to cart")
                    .font(.custom("Lexend-Bold", size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.orange)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 10)
        }
        .background(Color.black)
        .cornerRadius(10)
    }

    // Move to Cart Function
    private func moveToCart() {
        print("\(product.name) moved to cart")
    }
}

//// Preview
//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView()
//    }
//}
