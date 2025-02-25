import SwiftUI

struct ProductsView: View {
    @State private var favoriteProducts: Set<UUID> = []
    @State private var cartProducts: Set<UUID> = []
    
    let products = [
        Product(name: "Nike Hersey Classic Hoodie", price: "$55"),
        Product(name: "Nike Hersey Beanie", price: "$15"),
        Product(name: "Gildan Hersey Classic Sweatpants", price: "$25"),
        Product(name: "Gildan Hersey Classic Sweatshirt", price: "$35"),
        Product(name: "Adidas Hersey Joggers", price: "$45"),
        Product(name: "Champion Hersey Hoodie", price: "$60"),
        Product(name: "Under Armour Hersey Tee", price: "$20"),
        Product(name: "Puma Hersey Sweatpants", price: "$40")
    ]
    
    private var gridColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    Spacer()
                }
                .padding(.leading, 20)
                
                Image("DawgPoundLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .padding(.top, 10)
                    
                Text("Shirts - Women")
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                LazyVGrid(columns: gridColumns, spacing: 20) {
                    ForEach(products, id: \.id) { product in
                        VStack {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(height: 200)
                                .cornerRadius(10)
                                .overlay(
                                    Button(action: {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0)) {
                                            if favoriteProducts.contains(product.id) {
                                                favoriteProducts.remove(product.id)
                                            } else {
                                                favoriteProducts.insert(product.id)
                                            }
                                        }
                                    }) {
                                        Image(systemName: favoriteProducts.contains(product.id) ? "heart.fill" : "heart")
                                            .foregroundColor(favoriteProducts.contains(product.id) ? .red : .white)
                                            .padding(10)
                                            .scaleEffect(favoriteProducts.contains(product.id) ? 1.2 : 1.0)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    , alignment: .topTrailing
                                )
                            
                            Text(product.name)
                                .foregroundColor(.white)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 5)
                            
                            Text(product.price)
                                .foregroundColor(.white)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 5)
                            
                            Button(action: {
                                withAnimation {
                                    if cartProducts.contains(product.id) {
                                        cartProducts.remove(product.id)
                                    } else {
                                        cartProducts.insert(product.id)
                                    }
                                }
                            }) {
                                Text(cartProducts.contains(product.id) ? "Added to Cart" : "Move to Cart")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(cartProducts.contains(product.id) ? Color(red: 1.0, green: 0.5, blue: 0.0) : Color(red: 1.0, green: 0.65, blue: 0.0))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.top, 5)
                        }
                        .background(Color.black)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .scrollIndicators(.visible)
    }
}

struct Products: Identifiable {
    let id = UUID()
    let name: String
    let price: String
}

#Preview {
    ProductsView()
}
