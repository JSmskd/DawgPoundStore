//
//  StoreItem.swift
//  DawgPoundStore
//
//  Created by John Sencion on 12/13/24.
//

import SwiftUI
///ready to sell object
struct RST : Codable, Identifiable, Hashable {
    var size:String
    var col:String //becom style
    var qty:UInt
    var brand:String
    var details:String
    var price:Float
    var name:String
    var id:String { get {
        size + col + brand + name
    }}
    static func == (lhs: RST, rhs: RST) -> Bool {
        lhs.id == rhs.id
    }
}
//struct testRST:View {
//    let items:[RST] = [
//        .init(size: "Medium", col: "black", qty: 0, brand: <#T##String#>, details: <#T##String#>, price: <#T##Float#>, name: <#T##String#>),
//        .init(size: "-1", col: "light blue", qty: 10, brand: "some brand", details: "wawer", price: 10.99, name: "limited edition wawer bottle")//,
////        .init(size: "a", col: <#T##String#>, qty: 11, brand: <#T##String#>, details: <#T##String#>, price: <#T##Float#>, name: <#T##String#>)
//    ]
//    var body: some View {
//        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
//    }
//}
//#Preview {
//    testRST()
//}
