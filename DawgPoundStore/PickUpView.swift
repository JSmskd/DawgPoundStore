
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
                            CartView()
                            Divider().background(Color.gray)
                            CartView()
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
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$90")
                                    .foregroundColor(.white)
                            }
                            
                            HStack {
                                Text("Maintenance fee")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$8")
                                    .foregroundColor(.white)
                            }
                            
                            Divider()
                                .background(Color.gray)
                            
                            HStack {
                                Text("Total")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$98.00")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        
                        Button(action: {
                            // Action for Pickup Button
                        }) {
                            Text("Pick up")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color.orange)
                                .cornerRadius(10)
                        }
                    }
                    .frame(width: 200) // Fixed width for the right-side content
                    .padding()
                }
            }
        }
    }
}

#Preview {
    PickUpView()
}
