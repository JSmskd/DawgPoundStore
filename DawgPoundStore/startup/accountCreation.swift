//
//  accountCreation.swift
//  DawgPoundStore
//
//  Created by John Sencion on 5/30/25.
//
import SwiftUI
import CloudKit

struct account:View {
    @EnvironmentObject var model: ItemViewModel

    @State var username: String = ""
    @State var password: String = ""

    var valid:Bool { get {
        username.hasSuffix("@stu.d214.org") || username.hasSuffix("@stu.d214.org") }
    }
    var body: some View {
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

struct loginmenu: View {
    @EnvironmentObject var model: ItemViewModel
    @Binding var username: String
    @Binding var password: String

    @State var pres:Bool = false
    @State var hidePass: Bool = true

    @FocusState private var pasF
    @FocusState private var usrF
    var body: some View {
        HStack{
            Spacer()
            giatp()
            Divider().foregroundStyle(.white)
            //code
            VStack{
                VStack{
                    VStack{
                        TextField("flast####@stu.d214.org", text: $username)
                            .keyboardType(.emailAddress)
                            .focused($usrF)
                        HStack {
                            let psw = "password"
                            ZStack {
                                SecureField(psw, text: $password)
                                    .focused($pasF, equals: hidePass)
                                    .opacity(pasF ? 1.0 : 0.0)

                                TextField(psw, text: $password)
                                    .focused($pasF, equals: !hidePass)
                                    .opacity(!pasF ? 1.0 : 0.0)

                            }
                            ZStack{
                                Button(action: {
                                    pasF.toggle()
                                }, label: {
                                    Image(systemName: "eye").font(.title2)
                                })
                                .opacity((pasF) ? 1.0 : 0.0)
                                Button(action: {
                                    pasF.toggle()
                                }, label: {
                                    Image(systemName: "eye.slash").font(.title2)
                                })
                                .opacity(!pasF ? 1.0 : 0.0)
                            }
                            .buttonBorderShape(.roundedRectangle)
                            .foregroundStyle(.white)
                        }
                    }
                }
                .textFieldStyle(.roundedBorder)
                .foregroundStyle(.black)
                .tint(.gray)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .onKeyPress(.return) {
                    if pasF || usrF {
                        pasF = false
                        usrF = false
                        return .handled
                    }
                    return .ignored
                }
                HStack{
                    Button {
                        pres.toggle()
                    } label: {
                        Text("Forgot Password").foregroundStyle(.white).frame(height: 32).background(.blue).clipShape(RoundedRectangle(cornerRadius: 8))
                    }.alert("You will need to email DawgPound using your school email that you need changed, and tell us what your new password should be", isPresented: $pres) {
                        Button("open email",role: .none) {
                            //open emial
                        }.tint(.blue).foregroundStyle(.blue)
                        Button("nevermind", role: .cancel) {
                            //                        pres.toggle()
                        }.foregroundStyle(.red).tint(.red)
                        //                    print("hi")
                    }
                    Button {
                        Login(_model,username, password)
                    } label: {
                        Text("Log in").foregroundStyle(.white).frame(height: 32).background(.blue).clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
        Spacer()
    }
}

struct signupmenu: View {
    @EnvironmentObject var model: ItemViewModel
    @Binding var username: String
    @Binding var password: String

    @State var hidePass: Bool = true

    @FocusState private var pasF
    @FocusState private var usrF
    var body: some View {
        HStack{
            Spacer()
            giatp()
            Divider().foregroundStyle(.white)
            //code
            VStack{
                VStack{
                    VStack{
                        TextField("flast####@stu.d214.org", text: $username)
                            .keyboardType(.emailAddress)
                            .focused($usrF)
                        HStack {
                            let psw = "password"
                            ZStack {
                                SecureField(psw, text: $password)
                                    .focused($pasF, equals: hidePass)
                                    .opacity(pasF ? 1.0 : 0.0)

                                TextField(psw, text: $password)
                                    .focused($pasF, equals: !hidePass)
                                    .opacity(!pasF ? 1.0 : 0.0)

                            }
                            ZStack{
                                Button(action: {
                                    pasF.toggle()
                                }, label: {
                                    Image(systemName: "eye").font(.title2)
                                })
                                .opacity((pasF) ? 1.0 : 0.0)
                                Button(action: {
                                    pasF.toggle()
                                }, label: {
                                    Image(systemName: "eye.slash").font(.title2)
                                })
                                .opacity(!pasF ? 1.0 : 0.0)
                            }
                            .buttonBorderShape(.roundedRectangle)
                            .foregroundStyle(.white)
                        }
                    }
                }
                .textFieldStyle(.roundedBorder)
                .foregroundStyle(.black)
                .tint(.gray)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .onKeyPress(.return) {
                    if pasF || usrF {
                        pasF = false
                        usrF = false
                        return .handled
                    }
                    return .ignored
                }
                    Button {
                        Signup(_model,username, password)
                    } label: {
                        Text("Sign Up").foregroundStyle(.white).frame(height: 32).background(.blue).clipShape(RoundedRectangle(cornerRadius: 8))
                    }
            }
        }
        Spacer()
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
func accExists(_ model:EnvironmentObject<ItemViewModel>, _ u:String, _ p:String) -> (r:CKRecord?, e:Optional<any Error>) {

    let q = CKQuery.init(recordType: "account", predicate: NSPredicate(format: "schoolEmail == \(u) AND password == \(p)"))

    var output:(r:CKRecord?, e:Optional<any Error>) = (nil,nil)
    model.wrappedValue.database.fetch(withQuery: q, resultsLimit: 1) { a in
        DispatchQueue.main.async {
            var rr:CKRecord? = nil
            var ee:Optional<any Error> = nil
            do {
                let mr = try a.get().matchResults
                if mr.isEmpty {
                    throw CKError(.unknownItem)
                }
                let r = try mr.first.unsafelyUnwrapped.1.get()
                rr = r
            } catch {
                ee = error
                print(ee)
            }

            output = (rr,ee)
        }
    }
    return output
}
func initDevice(_ model:EnvironmentObject<ItemViewModel>, _ r:CKRecord) {
    //make the local user sync to the remote user
    //get the COOKIE thingy
    DispatchQueue.main.async{
        model.wrappedValue.usr.id = r["userCookie"] as! String
        model.wrappedValue.loginpromt = false
    }
}
func Login(_ model:EnvironmentObject<ItemViewModel>, _ u:String, _ p:String, ace:Optional<(r:CKRecord?, e:Optional<any Error>)>=nil) -> (r:CKRecord?, e:Optional<any Error>) {
    var ac = ace ?? accExists(model,u, p)
    if ac.r != nil {
        initDevice(model,ac.r!)
    }
    return (ac.r,ac.e)
}
func Signup(_ model:EnvironmentObject<ItemViewModel>, _ u:String, _ p:String) -> (r:CKRecord?, e:Optional<any Error>) {
    var ex = accExists(model,u, p)

    if ex.r != nil {
        return Login(model,u, p, ace: ex)
    }
    var rec:CKRecord = .init(recordType: "account")
    rec.setObject(UUID.init().uuidString as __CKRecordObjCValue, forKey: "userCookie")
    rec.setObject(u as __CKRecordObjCValue, forKey: "schoolEmail")
    rec.setObject(p as __CKRecordObjCValue, forKey: "password")

    model.wrappedValue.database.save(rec) { re, er in
//        DispatchQueue {
            ex.r = re
            ex.e = er
        if ex.e == nil {
            initDevice(model,ex.r!)
        }
        print(er)
//        }
    }

    return ex
    }
