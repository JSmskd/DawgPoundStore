import SwiftUI

struct IndividualItemView: View {
    var model:StateObject<ItemViewModel>
    var curentItem:Item
    init (_ model:StateObject<ItemViewModel>, item:Item) {
        curentItem = item
        //        trendingItems = []//model.wrappedValue.getTasks()
        if model.wrappedValue.items.isEmpty {
            model.wrappedValue.update()
        }

        //        model.wrappedValue.getUser()
        self.model = model
    }
//    @State private var selectedColor: Color = .gray
//    @State private var selectedSize: String? = nil
//    @State private var showSizePicker = false
//    @State private var isFavorite = false

    let colors: [Color] = [.white, Color(red: 0.43, green: 0.33, blue: 0.24), .gray]
    let sizes: [String] = ["S", "M", "L", "XL", "XXL"]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            HStack(spacing: 30) {
                VStack {
//                    Image("hoodie_image") // Ensure image is in assets
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(maxWidth: 500, maxHeight: 500)
                }

                VStack(alignment: .leading, spacing: 20) {
                    Text("DAWG\nPOUND")
                        .font(Font.custom("Lexend", size: 36).weight(.bold))
                        .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.11))

                    Spacer().frame(height: 11)

                    Text("Independent Trading Co.")
                        .font(Font.custom("Lexend", size: 16).weight(.light))
                        .foregroundColor(.white)

                    Text("\(curentItem.title)")
                        .font(Font.custom("Lexend", size: 24).weight(.semibold))
                        .foregroundColor(.white)

                    Text("\(curentItem.Itemdescription )")
                        .font(Font.custom("Lexend", size: 14).weight(.light))
                        .foregroundColor(.white)

                    Text("\(toPrice(curentItem.price))")
                        .font(Font.custom("Lexend", size: 24))
                        .foregroundColor(.white)

                    VStack(alignment: .leading) {
                        Text("Color")
                            .font(Font.custom("Lexend-Bold", size: 16).weight(.light))
                            .foregroundColor(.white)

//                        HStack(spacing: 15) {
//                            ForEach(colors, id: \.self) { color in
//                                Circle()
//                                    .fill(color)
//                                    .frame(width: 30, height: 30)
//                                    .overlay(
//                                        Circle()
//                                            .stroke(selectedColor == color ? Color.orange : Color.white, lineWidth: 2)
//                                    )
//                                    .onTapGesture {
//                                        selectedColor = color
//                                    }
//                            }
//                        }
                    }

                    Button(action: {
//                        showSizePicker.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 300, height: 50)

                            HStack {
                                Text(/*selectedSize ?? */"Select a Size")
                                    .font(Font.custom("Lexend", size: 16))
                                    .foregroundColor(.white)

                                Image(systemName: "chevron.down")
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                        }
                    }

//                    if showSizePicker {
//                        Picker("Select Size", selection: $selectedSize) {
//                            ForEach(sizes, id: \.self) { size in
//                                Text(size).tag(size as String?)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .frame(width: 300)
//                    }

                    HStack(spacing: 10) {
                        Button(action: {
                            // Add to cart functionality
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.orange)
                                    .frame(width: 300, height: 50)

                                Text("Add to cart - \(toPrice(curentItem.price))")
                                    .font(Font.custom("Lexend", size: 16))
                                    .foregroundColor(.white)
                            }
                        }

                        Button(action: {
//                            isFavorite.toggle()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.orange, lineWidth: 1)
                                    .frame(width: 50, height: 50)

                                Image(systemName: /*isFavorite ? "heart.fill" : */"heart")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .frame(maxWidth: 500)
                .padding()
            }
        }
    }
}

//struct HoodieView_Previews: PreviewProvider {
//    static var previews: some View {
//        IndividualItemView()
//    }
//}
