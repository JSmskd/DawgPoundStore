//
//  DawgPoundStoreApp.swift
//  DawgPoundStore
//
//  Created by John Sencion on 12/3/24.
//

import SwiftUI

@main
struct YourApp: App {
    @StateObject var model = ItemViewModel()
    var body: some Scene {
        WindowGroup {
            ap()
                .environmentObject(model)
        }
    }
}
struct ap: View {
    /*(ItemViewModel.self)*/
    @EnvironmentObject var model: ItemViewModel

    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        if !model.loginpromt {
            NavigationStack {
                HomeView()
                    .onAppear {
                        Timer.init(timeInterval: 0.5 , repeats: true) { t in
                            print("hi")
                            DispatchQueue.main.async {
                                if self._model.wrappedValue.timedown <= 0 {
                                    self._model.wrappedValue.update()
                                    self._model.wrappedValue.timedown = 5000
                                }
                            }
                        }.fire()
                    }
            }
        } else {
            VStack{
                TabView {
                    loginmenu(username: $username, password: $password).tabItem {
                        Text("log in").frame(width: 120, height: 44).fixedSize()
                    }.background(.black)
                    signupmenu(username: $username, password: $password).tabItem {
                        Text("sign up").frame(width: 120, height: 44).fixedSize()
                    }.background(.black)
                    noaccountmenu(username: $username).tabItem {
                        Text("no account").frame(width: 120, height: 44).fixedSize()
                    }.background(.black)
                }
            }

        }
    }


}
struct loginmenu: View {
    @EnvironmentObject var model: ItemViewModel
    @Binding var username: String
    @Binding var password: String
    @FocusState private var focused
    var body: some View {
        HStack{
            Spacer()
            giatp()
            Divider().foregroundStyle(.white)
            //code
            VStack{
                VStack{
                    TextField("flast####@stu.d214.org", text: $username).keyboardType(.emailAddress).focused($focused)
                    SecureField("Password", text: $password).keyboardType(.asciiCapable).focused($focused)
                }.textFieldStyle(.roundedBorder).foregroundStyle(.black).tint(.gray).autocorrectionDisabled().textInputAutocapitalization(.never).onKeyPress(.return) {
                    focused = false
                    return .handled
                }
                HStack{
                    Button {
                        model.loginpromt = false
                    } label: {
                        Text("Forgot Password").foregroundStyle(.white).frame(height: 32).background(.blue).clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    Button {
                        model.loginpromt = false
                    } label: {
                        Text("Log in").foregroundStyle(.white).frame(height: 32).background(.blue).clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            Spacer()
        }
    }
}
struct signupmenu: View {
    @EnvironmentObject var model: ItemViewModel
    @Binding var username: String
    @Binding var password: String
    @FocusState private var focused
    var body: some View {
        HStack{
            Spacer()
            giatp()
            Divider().foregroundStyle(.white)
            //code
            VStack{
                VStack{
                    TextField("flast####@stu.d214.org", text: $username).keyboardType(.emailAddress).focused($focused)
                    SecureField("Password", text: $password).keyboardType(.asciiCapable).focused($focused)
                }.textFieldStyle(.roundedBorder).foregroundStyle(.black).tint(.gray).autocorrectionDisabled().textInputAutocapitalization(.never).onKeyPress(.return) {
                    focused = false
                    return .handled
                }
                Button {
                    model.loginpromt = false
                } label: {
                    Text("Sign Up").foregroundStyle(.white).frame(height: 32).background(.blue).clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            Spacer()
        }
    }
}
struct noaccountmenu: View {
    @EnvironmentObject var model: ItemViewModel
    @FocusState private var focused
    @Binding var username: String
    var body: some View {
        HStack{
            Spacer()
            giatp()
            Divider()
            //code
            VStack{
                TextField("flast####@stu.d214.org", text: $username).keyboardType(.emailAddress).focused($focused).textFieldStyle(.roundedBorder).foregroundStyle(.black).tint(.gray).autocorrectionDisabled().textInputAutocapitalization(.never).onKeyPress(.return) {
                    focused = false
                    return .handled
                }
                Button {
                    model.loginpromt = false
                } label: {
                    Text("I Don't Want To Sign In").foregroundStyle(.white).frame(height: 32).background(.blue).clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }

            Spacer()
        }
    }
}
///Get It At The Pound
struct giatp: View {
//    private let alignment: Alignment = .trailing
    var body: some View {
        VStack{
            Text("Get it at").multilineTextAlignment(.trailing).frame(alignment: .trailing)
            VStack{
Text("The").multilineTextAlignment(.trailing).frame(alignment: .trailing)
                Text("Pound").foregroundStyle(.orange).multilineTextAlignment(.trailing).frame(alignment: .trailing)
            }
            .font(.custom("Lexend", size: 64))
            Text("All of Hersey’s merch in one").multilineTextAlignment(.trailing).frame(alignment: .trailing)
        }
        .font(.custom("Lexend", size: 32))
        .foregroundStyle(.white).bold()

    }
}
