import SwiftUI

struct MenuView: View {
    var isMenuOpen : Binding<Bool>
//    var model:StateObject<ItemViewModel>
    @EnvironmentObject var model: ItemViewModel
    init (/*_ model:StateObject<ItemViewModel>, */isMenuOpen imo:Binding<Bool>) {
//        self.model = model
        self.isMenuOpen = imo
        //            model.wrappedValue.update()
        //        DispatchQueue.main.async {
        //            model.wrappedValue.timedown -= 10
        //        }
    }
    @State private var expandedCategory: String? = nil // Tracks expanded category
    
    var body: some View {
        ZStack {
            if isMenuOpen.wrappedValue {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen.wrappedValue.toggle()
                        }
                    }
            }
            
            // Side Menu
            HStack {
                if isMenuOpen.wrappedValue {
                    VStack(alignment: .center, spacing: 10) {
                        Spacer()
                        
                        VStack(spacing: 15) {
                            menuItem(title: "IN-STOCK NOW", color: .white)
                            menuItem(title: "TRENDING NOW", color: .orange)
                            menuItem(title: "LIMITED EDITION", color: .brown)
                            
                            expandableMenuItem(title: "MEN")
                            if expandedCategory == "MEN" {
                                submenuItem(title: "TOPS")
                                submenuItem(title: "BOTTOMS")
                            }
                            
                            expandableMenuItem(title: "WOMEN")
                            if expandedCategory == "WOMEN" {
                                submenuItem(title: "TOPS")
                                submenuItem(title: "BOTTOMS")
                            }
                            
                            menuItem(title: "ACCESSORIES", color: .white)
                            menuItem(title: "OTHER", color: .white)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: 450, height: 750)
                    .background(Color("lightlightgray"))
                    .transition(.move(edge: .leading))
                    .animation(.easeInOut, value: isMenuOpen.wrappedValue)
                }
                
                Spacer()
            }
        }
    }
    
    // Regular menu items
    @ViewBuilder
    func menuItem(title: String, color: Color) -> some View {
        NavigationLink(destination: ProductsView(/*model*/)) {
            Text(title)
                .font(.custom("Lexend-Bold", size: 22))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
        }
    }
    
    // Expandable menu items (MEN, WOMEN)
    @ViewBuilder
    func expandableMenuItem(title: String) -> some View {
        Button(action: {
            withAnimation {
                if expandedCategory == title {
                    expandedCategory = nil // Collapse if already expanded
                } else {
                    expandedCategory = title // Expand this category
                }
            }
        }) {
            Text(title)
                .font(.custom("Lexend-Bold", size: 22))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
        }
    }
    
    // Submenu items (TOPS, BOTTOMS)
    @ViewBuilder
    func submenuItem(title: String) -> some View {
        NavigationLink(destination: ProductsView(/*model*/)) {
            Text(title)
                .font(.custom("Lexend-Regular", size: 18))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 5)
                .background(Color.white.opacity(0.8))
        }
        .transition(.opacity)
        .animation(.easeInOut, value: expandedCategory)
    }
}

// Preview
//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView(isMenuOpen: .constant(true))
//    }
//}

