import SwiftUI

struct Blnk {
    var cost: Int // quantity
}

struct CartView: View {
    var model: EnvironmentObject<ItemViewModel>
//    @State var cart: [orderItem]

    let STATICCART: Bool = false
    @State var hasAdded:orderItem?


    init(nyItem: orderItem) {
        model = .init()// ItemViewModel
//        STATICCART = false
//        print(model)
        hasAdded = nyItem
    }
    init() {
        model = .init()
//        @EnvironmentObject var model: ItemViewModel
    }

//    init(items: [orderItem] = []) {
//        cart = items
//        STATICCART = !items.isEmpty
//    }

    var itemTotal: Int {
        var t:Int = 0
        for i in model.projectedValue.order {
            t += (i.item.price.wrappedValue + i.style.price.wrappedValue + i.blnk.price.wrappedValue) * Int(truncatingIfNeeded: i.quantity.wrappedValue)
        }; return t
//        cart.reduce(0) { $0 + $1.item.price * $1.blnk.cost }
    }
    var total: Int {
        itemTotal + (model.wrappedValue.maintenanceFee * 100)
    }

    func reloadCart() {
//        if hasAdded != nil {
//            model.wrappedValue.objectWillChange.send()
//            model.wrappedValue.order.append(hasAdded!)
//            model.wrappedValue.objectWillChange.send()
//            hasAdded = nil
//        }
        if STATICCART { return }
        model.wrappedValue.update()
//        model.wrappedValue.cart
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
                        ForEach(model.wrappedValue.order.indices, id: \.self) { index in
                            CartItemView(order: Binding(get: {
                                model.wrappedValue.order[index]
                            }, set: { value in
                                model.wrappedValue.order[index] = value
                            }))
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
                        Text("Clothing cost (\(model.wrappedValue.order.count))")
                            .font(Font.custom("Lexend-Thin", size: 15))
                            .foregroundColor(.white)
                        Spacer()
                        Text(toPrice(itemTotal))
                            .font(Font.custom("Lexend-Thin", size: 15))
                            .foregroundColor(.white)
                    }

                    HStack {
                        Text("Maintenance fee")
                            .font(Font.custom("Lexend-Thin", size: 15))
                            .foregroundColor(.white)
                        Spacer()
                        Text(String(toPrice(model.wrappedValue.maintenanceFee * 100)))
                            .font(Font.custom("Lexend-Thin", size: 15))
                            .foregroundColor(.white)
                    }

                    Divider().background(Color.gray)

                    HStack {
                        Text("Total")
                            .font(Font.custom("Lexend-Bold", size: 24))
                            .foregroundColor(.white)
                        Spacer()
                        Text(String(toPrice(total)))
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
    @Binding var order: orderItem
//    @State private var quantity: Int

//    init(order: orderItem) {
//        self.order = order
//        _quantity = State(initialValue: order.blnk)
//    }

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
                Text(order.item.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                VStack {
                    Text(toPrice(order.item.price))
                    Text("Size \(order.item.Itemdescription)")
                    Text("\(order.style.name) : \(order.blnk.name)")
                }
                    .font(.system(size: 10))
                    .foregroundColor(.white)
            }

            Spacer()

            VStack {
                HStack(spacing: 20) {
                    Button(action: {
                        if $order.quantity.wrappedValue > 1 {
                            $order.quantity.wrappedValue -= 1
                            // update cart array in parent view
                        }
                    }) {
                        Text("-")
                            .font(.system(size: 25))
                            .foregroundColor(Color.gray)
                    }

                    Text("\($order.quantity.wrappedValue)")
                        .font(.system(size: 20))
                        .foregroundColor(Color.gray)

                    Button(action: {
                        $order.quantity.wrappedValue += 1
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

