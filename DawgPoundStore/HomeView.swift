import SwiftUI

struct HomeView: View {
    var model:StateObject<ItemViewModel>
    init (_ model:StateObject<ItemViewModel>) {
        self.model = model
//        trendingItems = []//model.wrappedValue.getTasks()
        model.wrappedValue.getTasks()
    }
//    let trendingItems:[Item]// = [
////        ("Nike Hersey Classic Hoodie", "$55"),
////    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Header Section
                ZStack(alignment: .bottomLeading) {
                    Image("HeaderImage") // Replace with your header image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 500)
                        .clipped()
                    
                    VStack(alignment: .leading) {
                        Text("The")
                            .foregroundColor(.white)
                        
                        Text("Pound.")
                            .foregroundColor(.orange)
                    }
                    .font(.custom("Lexend-Bold", size: 90))
                    .padding(.leading)
                    .padding(.bottom, 20)
                }
                
                // Search Bar and Action Icons
                HStack {
                    TextField("Search", text: .constant(""))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    HStack(spacing: 15) {
                        NavigationLink(destination: CartView()) {
                            Image(systemName: "cart")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                        }
                        NavigationLink(destination: FavoritesView()) {
                            Image(systemName: "heart")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    .padding(.trailing)
                }
                
                // Trending Section
                VStack(alignment: .leading) {
                    Text("Trending now")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(model.wrappedValue.items, id: \.self) { item in
                                Button(action: {
                                    print("\(item) tapped")
                                }) {
                                    ProductCard(productName: item.title, productPrice: toPrice(item.price))
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Featured Section
                Text("Show your best Husky pride with Dawg Pound.")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // FAQ Section
                VStack(alignment: .leading, spacing: 20) {
                    Text("FAQ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 20) {
                        ForEach(1...6, id: \.self) { index in
                            Button(action: {
                                print("FAQ \(index) tapped")
                            }) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Where do I get my order picked up?")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text("Answer etc. etc.")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(.systemGray6).opacity(0.2))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Footer
                Button(action: {
                    print("Email footer tapped")
                }) {
                    VStack {
                        Text("Email us with any other questions at")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                        
                        Link("dawgpound@d214.org", destination: URL(string:"mailto:dawgpound@d214.org")!)
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 3)
                    }
                }
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct ProductCard: View {
    let productName: String
    let productPrice: String
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 140, height: 140)
                .cornerRadius(8)
            
            Text(productName)
                .font(.subheadline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top, 5)
            
            Text(productPrice)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .frame(width: 140)
    }
}
func toPrice(_ doub:Double) -> String {
    let dollars = Int(doub)
    let cents = Int(doub * 100) - (dollars * 100)
    return "$\(dollars).\(cents)\(cents < 10 ? "0" : "")"
}
//
//struct DawgPoundInteractiveView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(StateObject(wrappedValue: ItemViewModel()))
//            .previewDevice("iPad Pro (11-inch) (4th generation)")
//    }
//}
