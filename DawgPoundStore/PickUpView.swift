
import SwiftUI

struct PickUpView: View {
    @State private var userMessage: String = ""
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                // Header
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    Image("DawgPoundLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    Spacer()
                }
                .padding()
                
                // Main content
                HStack(alignment: .top) {
                    // Cart Items with ScrollView
                    ScrollView {
                        VStack(spacing: 0) {
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
                            Divider().background(Color.gray)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    // Order Summary and Pickup Button
                    VStack(spacing: 15) {
                        VStack(spacing: 10) {
                            HStack {
                                Text("Clothing cost (2)")
                                    .font(Font.custom("Lexend-Regular", size: 15))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$90")
                                    .font(Font.custom("Lexend-Regular", size: 15))
                                    .foregroundColor(.white)
                            }
                            
                            HStack {
                                Text("Maintenance fee")
                                    .font(Font.custom("Lexend-Regular", size: 15))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$8")
                                    .font(Font.custom("Lexend-Regular", size: 15))
                                    .foregroundColor(.white)
                            }
                            
                            Divider()
                                .background(Color.gray)
                            
                            HStack {
                                Text("Total")
                                    .font(.headline)
                                    .font(Font.custom("Lexend-Regular", size: 24))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$98.00")
                                    .font(.headline)
                                    .font(Font.custom("Lexend-Regular", size: 24))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        
                        NavigationLink(destination: FinalView()) {
                            Text("Place order")
                                .font(.headline)
                                .font(Font.custom("Lexend-Regular", size: 24))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color.orange)
                                .cornerRadius(10)
                        }
                        
                        .frame(width: 200) // Fixed width for the right-side content
                        .padding()
                    }
                }
            }
        }
    }
}
    
    #Preview {
        PickUpView()
    }
