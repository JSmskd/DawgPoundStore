

import SwiftUI

struct IndividualItemView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            HStack(spacing: 30) {
               
                VStack {
                    Image("hoodie_image") //HOODIE?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 500, maxHeight: 500)
                }

               
                VStack(alignment: .leading, spacing: 20) {
                   
                    Text("DAWG\nPOUND")
                        .font(Font.custom("Lexend", size: 36).weight(.bold))
                        .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.11))
                    
                    Spacer().frame(height: 10)

                   
                    Text("Independent Trading Co.")
                        .font(Font.custom("Lexend", size: 16).weight(.light))
                        .foregroundColor(.white)

                    Text("Hersey Hoodie\nwith Husky Head")
                        .font(Font.custom("Lexend", size: 24).weight(.semibold))
                        .foregroundColor(.white)

                    Text("Heavyweight Hooded Sweatshirt")
                        .font(Font.custom("Lexend", size: 14).weight(.light))
                        .foregroundColor(.white)

                    // Price
                    Text("$45")
                        .font(Font.custom("Lexend", size: 24))
                        .foregroundColor(.white)

                    // Color Options
                    VStack(alignment: .leading) {
                        Text("Gray")
                            .font(Font.custom("Lexend", size: 16).weight(.light))
                            .foregroundColor(.white)

                        HStack(spacing: 15) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 1)
                                )

                            Circle()
                                .fill(Color(red: 0.43, green: 0.33, blue: 0.24))
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 1)
                                )

                            Circle()
                                .fill(Color.gray)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 1)
                                )
                        }
                    }

                    // Select Size Button
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 300, height: 50)

                        HStack {
                            Text("Select a Size")
                                .font(Font.custom("Lexend", size: 16))
                                .foregroundColor(.white)

                    
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    }

                    // Add to Cart Button
                    HStack(spacing: 10) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.orange)
                                .frame(width: 300, height: 50)

                            Text("Add to cart - $45")
                                .font(Font.custom("Lexend", size: 16))
                                .foregroundColor(.white)
                        }

                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.orange, lineWidth: 1)
                                .frame(width: 50, height: 50)

                            Image(systemName: "heart")
                                .foregroundColor(.white)
                        }
                    }
                }
                .frame(maxWidth: 500)
                .padding()
            }
        }
    }
}

struct HoodieView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualItemView()
    }
}
