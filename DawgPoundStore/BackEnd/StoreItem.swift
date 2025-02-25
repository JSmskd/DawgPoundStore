//
//  StoreItem.swift
//  DawgPoundStore
//
//  Created by John Sencion on 12/13/24.
//

import SwiftUI
import CloudKit

struct user {
    var id:CKRecord.ID?
    var whishes :[CKRecord.Reference]
    var email:String
    var accountStatus:String
    var itemsInCart:[Item?]
    init() {
        id = nil
        whishes = []
        email = ""
        accountStatus = ""
        itemsInCart = []
    }
}
struct orderItem:Identifiable {
    var id:CKRecord.Reference?
    var item:Item
    var quantity:Int64
    var style:String
    init (_ ref:Item,_ qty:Int64, _ sty:String, id:CKRecord.Reference? = nil) {
        //            itm = Item(reference: ref)
        quantity = qty
        style = sty
        item = ref

    }
}
struct Item:Identifiable, CustomStringConvertible, Hashable/*, Codable*/ {
    var description: String {
        return "\(title) : \(price)"
    }
    var id: CKRecord.ID?
    var title:String
    var Itemdescription:String
    var reference:CKRecord.Reference?
var images:[CKAsset]?
    var price:Double
    init(title: String, description: String, price: Double, images: [CKAsset]? = [], id: CKRecord.ID? = nil,reference: CKRecord.Reference? = nil) {
        self.id = id
        self.title = title
        self.Itemdescription = description
        self.images = images
        self.price = price
        self.reference = reference
    }
    init(_ title: String, _ description: String, _ price: Double, images: [CKAsset]? = [], id: CKRecord.ID? = nil, reference: CKRecord.Reference? = nil) {
        self.id = id
        self.title = title
        self.Itemdescription = description
        self.images = images
        self.price = price
        self.reference = reference
    }
}
///ready to sell object
@MainActor
class ItemViewModel: ObservableObject {
    func qry(recordID: CKRecord.ID) -> Item? {
        for i in items {
            if i.id == recordID {
                return i
            }
        }
        return nil
    }
    var database = CKContainer.default().publicCloudDatabase
    @Published var items:[Item] = []
    @Published var usr:user = user()
    @Published var cart:[orderItem] = []
    @Published var orders:[orderItem] = []
    @Published var userCookie : String = "ADMIN"

    func update() {
        getTasks()
        getUser(userCookie)
        getActiveCart()
    }
    func addTask(taskItem: inout Item) {

        let record = CKRecord(recordType: "Item")
        taskItem.id = record.recordID
        record.setObject(taskItem.title as CKRecordValue, forKey: "title")
        record.setObject(taskItem.description as CKRecordValue, forKey: "description")
        record.setObject((taskItem.images ?? []) as CKRecordValue, forKey: "images")
        record.setObject(taskItem.price as CKRecordValue, forKey: "price")

        database.save(record) { (record, error) in
            if error != nil {
                print(error as Any)
            } else {

                print("There")

            }
        }
    }
//    func placeOrder(d:Array<Item>) -> return type {
//        function body
//    }
    func getItem(id:CKRecord.Reference) -> Item? {
        for i in items {
            if i.id  == id.recordID {
                return i
            }
        }
        return nil
    }
    func getUser(_ cookie:String = "") {
        //        print("usera")
        var temp = user()
        temp.id = nil
        temp.whishes = []
        temp.email = ""
        temp.accountStatus = ""
        //format: "schoolEmail == 'jsension7366@stu.d214.org'"
        let predicate = NSPredicate(format: "userCookie == '\(cookie)'")

        let query = CKQuery(recordType: "account", predicate: predicate)
        self.database.fetch(withQuery: query) { [self] results in
            results.map {
                //                var name = ""
                                var newItems:[Item] = []
                $0.matchResults.map{$0.1.map { record in

                    temp.email
                    temp.accountStatus
                    temp.accountStatus
                    temp.id = record.recordID

                    for iter in record["cart"] as! [CKRecord.Reference] {
                        //                        database.

                        //                        print("recordName == '\(iter.recordID.recordName)'")//"iter.recordID.recordName.self)
//                        let q = CKQuery(recordType: "Item", predicate: NSPredicate(format: "___recordID == %@", iter.recordID))
//                        print("\(q.recordType);  \(q.predicate)")
                        self.database.fetch(withRecordID: iter.recordID) { r,e in
//                            print("map0")
//                            print(e)
                            if r == nil {
                                print("sad :(")
                            } else {
//                                print(r!)
                                print(r!.allKeys())
                                print(r!["quantity"] as! Int64)
                                print(r!["style"] as! String)
                                var q = r!["quantity"] as! Int64
                                var s = r!["style"] as! String
                                var ordItem:Item?
//                                self.database.fetch(withRecordID: (r!["Item"] as! CKRecord.Reference).recordID) { itm,e in
//                                    if r == nil {
//                                        print("sad :(")
//                                    } else {
//                                        //
//                                        print(itm?.recordType)
//                                        print(itm!.allKeys())
//                                        ordItem = .init(itm!["title"] as! String, itm!["description"] as! String, itm!["price"] as! Double, id: itm!.recordID, reference: r!["Item"] as! CKRecord.Reference)
//                                    }
//                                }
//                                if ordItem == nil {
//                                    print(":(")
//                                } else {
                                temp.whishes.append(r!["Item"] as! CKRecord.Reference)
//                                }
                            }

                        }
                        //                        fetch(withRecordID: iter.,completionHandler: @escaping (CKRecord?, (any Error)?) -> Void)

                    }
                }
                }
            }
            DispatchQueue.main.async {
                self.usr = temp
            }
        }
    }
    func getActiveCart() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Item", predicate: predicate)
        //        let queryOperation = CKQueryOperation(query: query)
        database.fetch(withQuery: query) { results in
            //            print("start of fetch")

            results.map {//var newItems:[Item] = []
                $0.matchResults.map({$0.1.map { record in
                    //                print("<STARTRECORD")
                    //                print("------------------------")
                    //                print("------------------------")
                    //                print(record)
//                    newItems.append(Item(title: record["title"] as! String, description: record["description"] as! String, price: record["price"] as! Double, images: record["images"] as? [CKAsset] , id: record.recordID, reference: CKRecord.Reference.init(recordID: record.recordID, action: .none)))
                    //                print("------------------------")
                    //                print("------------------------")
                    //                print("ENDRECORD>")
                }})
                DispatchQueue.main.async {
//                    self.items = newItems
//                    print(self.items)
                }
            }
            //            print(results)
        }

//                queryOperation.queryResultBlock = { results in
//                    print(results)
//                }

    }
    func getTasks() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Item", predicate: predicate)
//        let queryOperation = CKQueryOperation(query: query)
        database.fetch(withQuery: query) { results in
//            print("start of fetch")

            results.map {var newItems:[Item] = []
                $0.matchResults.map({$0.1.map { record in
//                print("<STARTRECORD")
//                print("------------------------")
//                print("------------------------")
//                print(record)
                    newItems.append(Item(title: record["title"] as! String, description: record["description"] as! String, price: record["price"] as! Double, images: record["images"] as? [CKAsset] , id: record.recordID, reference: CKRecord.Reference.init(recordID: record.recordID, action: .none)))
//                print("------------------------")
//                print("------------------------")
//                print("ENDRECORD>")
            }})
                DispatchQueue.main.async {
                    self.items = newItems
                }
            }
//            print(results)
        }

//        queryOperation.queryResultBlock = { results in
//            print(results)
//        }
    }
}
