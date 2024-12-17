import SwiftUI

struct FavoritesView: View {
    // Sample Product Data
    let products = [
        Product(name: "Nike Hersey Classic Hoodie", price: "$55"),
        Product(name: "Nike Hersey Beanie", price: "$15"),
        Product(name: "Gildan Hersey Classic Sweatpants", price: "$25"),
        Product(name: "Gildan Hersey Classic Sweatshirt", price: "$35"),
        Product(name: "Nike Hersey Classic Hoodie", price: "$55"),
        Product(name: "Nike Hersey Beanie", price: "$15"),
        Product(name: "Gildan Hersey Classic Sweatpants", price: "$25"),
        Product(name: "Gildan Hersey Classic Sweatshirt", price: "$35")
    ]

    // Dynamic Grid Layout
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Button(action: {
                 
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

         
            Text("My Favorites")
                .font(.custom("Lexend-Regular", size: 24))
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top, 10)

           
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(products, id: \.id) { product in
                        ProductView(product: product)
                    }
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
}

// Single Product Card View
struct ProductView: View {
    let product: Product
    let cardHeight: CGFloat = 180

    var body: some View {
        VStack(spacing: 0) {
            
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: cardHeight)
                .overlay(
                    Image(systemName: "heart")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .medium))
                        .padding(8),
                    alignment: .topTrailing
                )

     
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

          
            Button(action: {
               
            }) {
                Text("Move to cart")
                    .font(.custom("Lexend-Bold", size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.orange)
                    .cornerRadius(8)
            }
        }
        .background(Color.black)
        .cornerRadius(10)
    }
}


struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
          
    }
}

