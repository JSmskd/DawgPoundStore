import SwiftUI

struct FinalView: View {
//    var model:StateObject<ItemViewModel>
    @EnvironmentObject var model: ItemViewModel
    init (/*_ model:StateObject<ItemViewModel>*/) {
//        self.model = model
    }
    var body: some View {
        Text("Thank you for ordering!")
            .font(.custom("Lexend-Regular", size: 24))
            .padding()
        
        ZStack {
            Rectangle()
                .foregroundStyle(Color.gray.opacity(0.3))
                .frame(width: 1000, height: 150)
                .cornerRadius(10)
            Text("An email has been sent to your inbox to confirm your purchase.")
                .font(.custom("Lexend-Regular", size: 24))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
        }
        
        
        NavigationLink {
            HomeView(/*model*/)
        } label: {
            Text("Return to Home Page")
                .font(Font.custom("Lexend-Regular", size: 24))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .cornerRadius(10)
        }
        .padding()
        .cornerRadius(10)
    }
}

