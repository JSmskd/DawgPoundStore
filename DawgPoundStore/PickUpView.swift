import SwiftUI

struct PickUpView: View {
    //    var model:StateObject<ItemViewModel>
    @EnvironmentObject var model: ItemViewModel
    init(){}
    var body: some View {
        @AppStorage("email") var email: String = ""
        @AppStorage("time") var time: String = ""
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Background color

            VStack {
                // Header
                HStack {
                    Spacer()
                    Text("Pick Up Order")
                        .font(Font.custom("Lexend-Bold", size: 24))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()

                VStack {
                    Text("Pick up info")
                        .font(Font.custom("Lexend-Bold", size: 24))
                        .foregroundColor(.white)
                        .padding()
                    VStack(spacing: 16) {
                        TextField("Email (e.g. jhersey1234@stu.d214.org): ", text: $email)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(25)
                            .foregroundColor(.white)
                        TextField("Time (e.g. 2/25/25 @ 12 pm): ", text: $time)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(25)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                }
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .padding()


                // Cart Items
                List{
                    ForEach(_model.projectedValue.order, id:\.self) { i in
                        VStack(spacing: 20) {
                            HStack {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)

                                VStack(alignment: .leading, spacing: 5) {
                                    Text(i.wrappedValue.item.title )
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

                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                    }
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

                NavigationLink(destination: FinalView(/*model*/)) {
                    Text("Place order")
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
