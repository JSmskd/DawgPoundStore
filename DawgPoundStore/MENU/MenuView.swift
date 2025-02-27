
import SwiftUI

struct MenuView: View {
    @Binding var isMenuOpen: Bool
    var body: some View {
        VStack(alignment: .leading) {
            ZStack{
                if isMenuOpen {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isMenuOpen.toggle()
                            }
                        }
                    VStack(alignment: .leading) {
                        Text("Menu")
                            .font(.largeTitle)
                            .padding(.top, 50)
                        VStack {
                            Button("Pants") {}
                                .padding()
                            Button("Shirts") {}
                                .padding()
                        }
                        .transition(.opacity)
                        .animation(.easeIn, value: isMenuOpen)
                        
                        Spacer()
                    }
                    .frame(width: 200)
                    .background(Color.white)
                    .transition(.move(edge: .leading))
                }
            }
        }
    }
}
