import SwiftUI
import CloudKit
struct HomeView: View {
    //    var model:StateObject<ItemViewModel>
    @EnvironmentObject var model: ItemViewModel
    @State var colecs:[ic] = []
    init () {
        UIRefreshControl.appearance().tintColor = UIColor.white
        UIRefreshControl.appearance().attributedTitle = NSAttributedString("Refreshing…")
    }
    
    @State var isMenuOpen = false
    let colors = customColors()
    var body: some View {
        ZStack (alignment:.topLeading){
            ScrollView(.vertical) {
                VStack {
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
                                .offset(y: 80)
                                .onTapGesture(count: 3) {
                                    model.JDebugMode = true
                                }

                            Text("Pound.")
                                .foregroundColor(colors["orange"] ?? .black)
                                .offset(y: 30)
                                .onTapGesture(count: 3) {
                                    model.JDebugMode = false
                                }
                        }
                        .font(.custom("Lexend-Bold", size: 130))
                        .padding(.leading)
                        .padding(.bottom, 20)
                    }
                    // Search Bar and Action Icons
                    HStack {
                        TextField("Search", text: .constant(""))
                            .font(.custom("Lexend-Thin", size: 15))
                            .padding()
                            .background((colors["lightLightGray"] ?? .black))
                            .cornerRadius(50)
                            .padding(.horizontal)
                            .offset(x: 8, y: 15)
                        
                        HStack(spacing: 15) {
                            NavigationLink(destination: CartView(/*model*/)) {
                                Image(systemName: "cart")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    .offset(y: 15)
                            }
                            NavigationLink(destination: FavoritesView(/*model*/)) {
                                Image(systemName: "heart")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    .offset(y: 15)
                            }
                        }
                        .padding(.trailing)
                    }
                    
                    
                    
                    
                    HomeItems($colecs)
                    // Featured Section
                    
                    Text("Show your best Husky pride with Dawg Pound.")
                        .font(.custom("Lexend-Bold", size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    
                    faqs()
                    
                    email()
                    
                }
            }.background(Color.black).refreshable {
                refAct()
            }
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            isMenuOpen.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .frame(width: 30, height: 20)
                            .padding()
                            .foregroundStyle(.gray)
                    }
                    .foregroundStyle(.gray)
                    Spacer()
                }
                Spacer()
            }
            .foregroundStyle(Color.clear)
            .frame(width: 30, height: 20).offset(x: 15, y: 15)
            MenuView(/*model, */isMenuOpen: $isMenuOpen).frame(alignment: .leading)
        }
        .onAppear {
            refAct()
        }
    }
    func refAct() {
        _model.wrappedValue.update(true)
        colecs = _model.wrappedValue.homeColecs
        print("update")
    }
}

struct ProductCard: View {
    let productName: String
    let productPrice: String
    
    var body: some View {
        VStack {
            Rectangle()
//                .fill(Color.gray)
                .frame(width: 140, height: 140)
                .cornerRadius(8)
                .foregroundStyle(.gray)

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

func toPrice(_ doub:Int) -> String {
    let cuttoff = 10000
    let dollars:Int = doub / cuttoff
    let cent = doub % cuttoff
    var cents = cent.description
    while cents.last == "0" {
        cents.removeLast()
    }
    while cents.count < 2 {
        cents += "0"
    }
    //    let cents:Int = doub - (dollars * 10000)
    return "$\(dollars).\(cents)"
}

