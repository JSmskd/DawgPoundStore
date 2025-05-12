//
//  StoreItem.swift
//  DawgPoundStore
//
//  Created by John Sencion on 12/13/24.
//

import SwiftData
import SwiftUI
import CloudKit

struct user:Hashable {
    var id:CKRecord.ID?
    var whishes :[CKRecord.Reference]
    var email:String
    var accountStatus:String
    var itemsInCart:[Item?]
    init() {
        id = nil
        whishes = []
        email = "jsenicon7366@stu.d214.org"
        accountStatus = ""
        itemsInCart = []
    }
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
                    //                    print("\(self.name)")
                    //                    Item.init(String, String, Double, images: [CKAsset]?, id: CKRecord?, reference: CKRecord.Reference?)
                    var useit:Item = .init(o!["title"] as! String, o!["description"] as! String, (o!["cost"] as! Int), images: o!["images"] as? Array<CKAsset>,id: o)
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
