
import SwiftUI

struct MenuView: View {
    @Binding var isMenuOpen: Bool
    var body: some View {
        //        VStack(alignment: .leading) {
        //            if isMenuOpen {
        //                Color.black.opacity(0.3)
        //                    .edgesIgnoringSafeArea(.all)
        //                    .onTapGesture {
        //                        withAnimation {
        //                            isMenuOpen.toggle()
        //                        }
        //                    }
        //                VStack(alignment: .leading) {
        //                    HStack {
        //                        //                        commented to keep from crashing
        //                        //unable to find in scope :(
        //                        //                        NavigationLink(destination: MenuMenView()) {
        //                        //                            Text("MEN")
        //                        //                                .font(.custom("Lexend-Bold", size: 20))
        //                        //                                .foregroundColor(.white)
        //                        //                                .padding()
        //                        //                        }
        //                        //                        NavigationLink(destination: MenuMenView()) {
        //                        //                            Text("WOMEN")
        //                        //                                .font(.custom("Lexend-Bold", size: 20))
        //                        //                                .foregroundColor(.white)
        //                        //                                .padding()
        //                        //                        }
        //                        //                        NavigationLink(destination: MenuMenView()) {
        //                        //                            Text("ACCESSORIES")
        //                        //                                .font(.custom("Lexend-Bold", size: 20))
        //                        //                                .foregroundColor(.white)
        //                        //                                .padding()
        //                        //                        }
        //                        //                        NavigationLink(destination: MenuMenView()) {
        //                        //                            Text("OTHER")
        //                        //                                .font(.custom("Lexend-Bold", size: 20))
        //                        //                                .foregroundColor(.white)
        //                        //                                .padding()
        //                        //                        }
        //                    }
        //                    Text("Menu")
        //                        .font(.largeTitle)
        //                        .padding(.top, 50)
        //                    VStack {
        //                        Button("Pants") {}
        //                            .padding()
        //                        Button("Shirts") {}
        //                            .padding()
        //                        ZStack{
        if isMenuOpen {
            ZStack{
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
                //                    .transition(.opacity)
                .animation(.easeIn, value: isMenuOpen)

                Spacer()
            }
//            .frame(width: 500, height: 700)
            .frame(alignment: .leading)
            .background(Color.black.opacity(0.3))
            .transition(.move(edge: .leading))
        }
    }
}
