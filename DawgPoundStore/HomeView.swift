import SwiftUI
import CloudKit

struct HomeView: View {
//    var model:StateObject<ItemViewModel>
    @EnvironmentObject var model: ItemViewModel
    @State var colecs:[ic] = []
    init (_ model:StateObject<ItemViewModel>? = nil) {
//        @Environment(model.self) var model
        //        trendingItems = []//model.wrappedValue.getTasks()
        //        if model.wrappedValue.colecs.isEmpty {
        //            model.wrappedValue.update()
        //        }
        //        model.wrappedValue.update()
        //        DispatchQueue.main.async {
        //            print("-10")
        //            model.wrappedValue.timedown -= 1
        //        }
        
        //        model.wrappedValue.getUser()
//        self.model = model
        
        UIRefreshControl.appearance().tintColor = UIColor.white
        UIRefreshControl.appearance().attributedTitle = NSAttributedString("Refreshing…")
    }
    //    let trendingItems:[Item]// = [
    ////        ("Nike Hersey Classic Hoodie", "$55"),
    ////    ]
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
                                .foregroundColor(.white ?? .black)
                                .offset(y: 80)
                            
                            Text("Pound.")
                                .foregroundColor(colors["orange"] ?? .black)
                                .offset(y: 30)
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
                    
                    HomeItems(/*model, */$colecs)
                    // Featured Section
                    Text("Show your best Husky pride with Dawg Pound.")
                        .font(.custom("Lexend-Bold", size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    
                    faq()
                    
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
//
//struct DawgPoundInteractiveView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(StateObject(wrappedValue: ItemViewModel()))
//            .previewDevice("iPad Pro (11-inch) (4th generation)")
//    }
//}
struct HomeItems: View {
//    var model:StateObject<ItemViewModel>
    @EnvironmentObject var model: ItemViewModel
    var itms:Binding<[ic]>
    init (_ itms:Binding<[ic]>) {
        //self.model = model
        //        print("{")
        self.itms = itms
        //        for i in model.wrappedValue.homeColecs {
        //            //            print(i.name)
        //            //            for o in i.items {
        //            ////                print(o)
        //            //            }
        //        }
        //        print("}")
    }
    var body: some View {
        // Trending Section
        VStack{
            //            ForEach(0..<model.wrappedValue.homeColecs.count, id:\.self) { noeh in
            //                VStack(alignment: .leading) {
            //                    Text("Trending now")
            //                        .font(.custom("Lexend-Regular", size: 25))
            //                        .foregroundColor(.white)
            //                        .padding(.horizontal)
            //                        .offset(x: 8, y: 15)
            //
            //                    ScrollView(.horizontal, showsIndicators: false) {
            //                        HStack(spacing: 16) {
            //                            ForEach(0..<min(5,(model.wrappedValue.homeColecs)[noeh].items.count), id: \.self) { item in
            //                                itemPreview(model, item: (model.wrappedValue.homeColecs)[noeh].items[item])
            //                                //                                        item.preview
            //                            }
            //                        }
            //                        .padding(.horizontal)
            //                    }
            //                }
            //            }
            ForEach(itms.wrappedValue, id:\.self) { noeh in
                VStack(alignment: .leading) {
                    Text(noeh.name)
                        .font(.custom("Lexend-Regular", size: 25))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    //                        .offset(x: 8, y: 15)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(noeh.items, id: \.self) { item in
                                itemPreview(/*model, */item: item)
                                //                                        item.preview
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
struct faq: View {
    //("question","answer")
    let questions:Array<(String,String)> = [
        ("Where do I get my order picked up?","Answer Etc. Etc."),
        ("Where do I get my order picked up?","Answer Etc. Etc."),
        ("Where do I get my order picked up?","Answer Etc. Etc."),
        ("Where do I get my order picked up?","Answer Etc. Etc."),
        ("Where do I get my order picked up?","Answer Etc. Etc."),
        ("Where do I get my order picked up?","Answer Etc. Etc.")
    ]
    var body: some View {
        // FAQ Section
        VStack(alignment: .leading, spacing: 20) {
            Text("FAQ")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 20) {
                ForEach(0..<questions.count, id: \.self) { index in
                    Button(action: {
                        print("FAQ \(index) tapped")
                    }) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(questions[index].0)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(questions[index].1)
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
    }
}

#Preview {
    faq()
}
