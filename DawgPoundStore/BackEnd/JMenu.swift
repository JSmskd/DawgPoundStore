//
//  JMenu.swift
//  DawgPoundStore
//
//  Created by John Sencion on 5/12/25.
//

import SwiftUI
struct GODMODE: View {
    @EnvironmentObject var model : ItemViewModel
    @State var email : String = ""
    var body: some View {
        VStack{
            HStack {
                Button("Lock Email") {
                    model.usr.email = email
                }
                TextField("Email", text: $email)
            }
            //            HStack {
            //                Button("Lock Time") {
            //
            //                }
            //            }



        }
    }
}

