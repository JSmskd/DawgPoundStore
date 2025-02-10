import SwiftUI

struct ProductsView: View {
    let items = [
        ("Nike", "Hersey Classic Hoodie", "$55"),
        ("Nike", "Hersey Beanie", "$15"),
        ("Gildan", "Hersey Classic Sweatpants", "$25"),
        ("Gildan", "Hersey Classic Sweatshirt", "$35")
    ]
    
    @State private var favorites: Set<String> = []
    @State private var cart: Set<String> = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("DAWG POUND")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.orange)
                .padding(.top)
            
            Text("Shirts - Women")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.leading)
                .padding(.top, 5)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(items, id: \.[1]) { brand, name, price in
                        VStack(spacing: 10) {
                            ZStack(alignment: .topTrailing) {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 150)
                                    .cornerRadius(10)
                                
                                Button(action: {
                                    if favorites.contains(name) {
                                        favorites.remove(name)
                                    } else {
                                        favorites.insert(name)
                                    }
                                }) {
                                    Image(systemName: favorites.contains(name) ? "heart.fill" : "heart")
                                        .foregroundColor(favorites.contains(name) ? .red : .gray)
                                        .padding(8)
                                }
                            }
                            
                            Text(brand)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(name)
                                .font(.headline)
                            Text(price)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Button(action: {
                                if cart.contains(name) {
                                    cart.remove(name)
                                } else {
                                    cart.insert(name)
                                }
                            }) {
                                Text(cart.contains(name) ? "Added to cart" : "Move to cart")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
        }
        .background(Color.black)
        .foregroundColor(.white)
    }
}

#Preview {
    ProductView()
}
