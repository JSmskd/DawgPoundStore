//
//  StoreItem.swift
//  DawgPoundStore
//
//  Created by John Sencion on 12/13/24.
//

import SwiftData
import SwiftUI
import CloudKit

struct user {
    @AppStorage("uuid") public var id:String = ""
    public var whishes :[CKRecord.ID] { get {
        var output:[CKRecord.ID] = []
        for i in wish.split(separator: ",") {
            output.append(CKRecord.ID(recordName: id))
        }
        return output
    }
    set {
        var save:String = ""
        for i in newValue {
            save += i.recordName
        }
        wish = save
    }}
    @AppStorage("wish") private var wish:String = ""
    @AppStorage("email") public var email:String = ""
    @AppStorage("acStatus") public var accountStatus:String = ""
    public var itemsInCart:[CKRecord.ID] {get {
        var output:[CKRecord.ID] = []
        for i in wish.split(separator: ",") {
            output.append(CKRecord.ID(recordName: id))
        }
        return output
    } set {
        var save:String = ""
        for i in newValue {
            save += i.recordName
        }
        cart = save
    }}
    @AppStorage("cart") private var cart:String = ""
    init() {}
//    init() {
//        id = ""
//        whishes = []
//        email = ""
//        accountStatus = ""
//        itemsInCart = []
//    }
}
///item collection
class ic : Identifiable, Hashable{
    var name:String
    var desc:String
    var items:[Item] = []
    var id: String { "\(name):\(desc)" }
    init(name: String, desc: String, itemRefs:[CKRecord.ID]) {
        self.name = name
        self.desc = desc
    }
    init (_ cloudkitRecord:CKRecord) {
        //        print(cloudkitRecord)
        name = cloudkitRecord["Name"] as! String
        desc = cloudkitRecord["collectionDescription"] as! String
        //        cloudkitRecord.recordID.recordName
        //        print(cloudkitRecord["items"] as! [CKRecord.Reference])
        for i in cloudkitRecord["items"] as! [CKRecord.Reference] {
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: i.recordID) { o,e in
                //                print(o)
                if o == nil {
                    //                    print("\(i.recordID.recordName) = nil")
                } else {
                    let useit:Item = .init(o!)
                    //                        print(useit)
                    DispatchQueue.main.async {
                        self.items.append(useit)
                    }
                }
            }
        }
    }
    static func != (lhs:ic,rhs:ic) -> Bool {
        !(lhs == rhs)
    }
    static func == (lhs:ic,rhs:ic) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}
///ready to sell object
