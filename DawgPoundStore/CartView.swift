import SwiftUI

struct Blnk {
    var cost: Int // quantity
}

struct CartView: View {
    @EnvironmentObject var model: ItemViewModel
    @State var cart: [orderItem]
    
    let maintenanceFee: Int = 800 // $8.00
    let STATICCART: Bool

    init(items: [orderItem] = []) {
        cart = items
        STATICCART = !items.isEmpty
    }

    var itemTotal: Int {
        cart.reduce(0) { $0 + $1.item.price * $1.blnk.cost }
    }

    var total: Int {
        itemTotal + maintenanceFee
    }

    func reloadCart() {
        if STATICCART { return }
        _model.wrappedValue.update()
        cart = _model.wrappedValue.cart
    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                // Header
                HStack {
                    Spacer()
                    Text("My Cart")
                        .font(Font.custom("Lexend-Bold", size: 24))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()

                // Cart Items
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(cart.indices, id: \.self) { index in
                            CartItemView(order: cart[index])
                        }
                    }
                    .padding(.horizontal)
                }

                // Order Summary
                VStack(alignment: .leading, spacing: 10) {
                    Text("Order Summary")
                        .font(Font.custom("Lexend-Bold", size: 24))
                        .foregroundColor(.white)

                    HStack {
                        Text("Clothing cost (\(cart.count))")
                            .font(Font.custom("Lexend-Thin", size: 15))
                            .foregroundColor(.white)
                        Spacer()
                        Text(String(format: "$%.2f", Double(itemTotal) / 100.0))
                            .font(Font.custom("Lexend-Thin", size: 15))
                            .foregroundColor(.white)
                    }

                    HStack {
                        Text("Maintenance fee")
                            .font(Font.custom("Lexend-Thin", size: 15))
                            .foregroundColor(.white)
                        Spacer()
                        Text(String(format: "$%.2f", Double(maintenanceFee) / 100.0))
                            .font(Font.custom("Lexend-Thin", size: 15))
                            .foregroundColor(.white)
                    }

                    Divider().background(Color.gray)

                    HStack {
                        Text("Total")
                            .font(Font.custom("Lexend-Bold", size: 24))
                            .foregroundColor(.white)
                        Spacer()
                        Text(String(format: "$%.2f", Double(total) / 100.0))
                            .font(Font.custom("Lexend-Bold", size: 24))
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)

                NavigationLink(destination: PickUpView()) {
                    Text("Pick up")
                        .font(Font.custom("Lexend-Bold", size: 24))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .onAppear {
            reloadCart()
        }
    }
}

// MARK: - CartItemView

struct CartItemView: View {
    var order: orderItem
    @State private var quantity: Int

    init(order: orderItem) {
        self.order = order
        _quantity = State(initialValue: order.blnk.cost)
    }

    var body: some View {
        HStack {
            //Image(order.item.//imagename)
                //.resizable()
                //.frame(width: 80, height: 80)
                //.background(Color.gray.opacity(0.2))
                //.cornerRadius(10)

            VStack(alignment: .leading, spacing: 5) {
                Text("Independent Trading Co.")
                    .font(.system(size: 10, weight: .light))
                    .foregroundColor(.white)
                Text(order.item.name)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                Text(order.item.color)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                Text("Size \(order.item.size)")
                    .font(.system(size: 10))
                    .foregroundColor(.white)
            }

            Spacer()

            VStack {
                HStack(spacing: 20) {
                    Button(action: {
                        if quantity > 1 {
                            quantity -= 1
                            // update cart array in parent view
                        }
                    }) {
                        Text("-")
                            .font(.system(size: 25))
                            .foregroundColor(Color.gray)
                    }

                    Text("\(quantity)")
                        .font(.system(size: 20))
                        .foregroundColor(Color.gray)

                    Button(action: {
                        quantity += 1
                        // update cart array in parent view
                    }) {
                        Text("+")
                            .font(.system(size: 25))
                            .foregroundColor(Color.gray)
                    }
                }
                .padding()
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

