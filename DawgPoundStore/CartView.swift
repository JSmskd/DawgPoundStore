import SwiftUI

struct CartView: View {
    var body: some View {
        ZStack {
                    Color.black.edgesIgnoringSafeArea(.all) // Background color
                    
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
                                CartItemView()
                                CartItemView()
                            }
                            .padding(.horizontal)
                        }
                        
                        // Order Summary
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Order Summary")
                                .font(Font.custom("Lexend-Bold", size: 24))
                                .foregroundColor(.white)
                            
                            HStack {
                                Text("Clothing cost (2)")
                                    .font(Font.custom("Lexend-Thin", size: 15))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$90")
                                    .font(Font.custom("Lexend-Thin", size: 15))
                                    .foregroundColor(.white)
                            }
                            
                            HStack {
                                Text("Maintenance fee")
                                    .font(Font.custom("Lexend-Thin", size: 15))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$8")
                                    .font(Font.custom("Lexend-Thin", size: 15))
                                    .foregroundColor(.white)
                            }
                            
                            Divider()
                                .background(Color.gray)
                            
                            HStack {
                                Text("Total")
                                    .font(Font.custom("Lexend-Bold", size: 24))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$98.00")
                                    .font(Font.custom("Lexend-Bold", size: 24))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                        // Pickup Button
                        Button(action: {
                            PickUpView()
                        }) {
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
            }
        }

        struct CartItemView: View {
            var body: some View {
                HStack {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Independent Trading Co.")
                            .font(.system(size: 10, weight: .light))
                            .foregroundColor(.white)
                        Text("Hersey Hoodie with Husky Head")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                        Text("Gray")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                        Text("Size S")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    VStack {
                        Button(action: { print("Decrease quantity") }) {
                            Text("-")
                                .font(.system(size: 24))
                                .foregroundColor(Color.gray)
                        }
                        Text("1")
                            .font(.system(size: 15))
                            .foregroundColor(Color.gray)
                        Button(action: { print("Increase quantity") }) {
                            Text("+")
                                .font(.system(size: 24))
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
        }

        struct CartView_Previews: PreviewProvider {
            static var previews: some View {
                CartView()
            }
        }
