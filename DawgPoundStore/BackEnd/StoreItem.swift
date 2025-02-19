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
    init() {
        id = nil
        whishes = []
        email = ""
        accountStatus = ""
    }
}
struct Item:Identifiable, Hashable/*, Codable*/ {
    var id: CKRecord.ID?
    var title:String
    var description:String
    var reference:CKRecord.Reference?
var images:[CKAsset]?
    var price:Double
    init(title: String, description: String, price: Double, images: [CKAsset]? = [], id: CKRecord.ID? = nil,reference: CKRecord.Reference? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.images = images
        self.price = price
        self.reference = reference
    }
    init(_ title: String, _ description: String, _ price: Double, images: [CKAsset]? = [], id: CKRecord.ID? = nil, reference: CKRecord.Reference? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.images = images
        self.price = price
        self.reference = reference
    }
}
///ready to sell object
@MainActor
class ItemViewModel: ObservableObject {
    var database = CKContainer.default().publicCloudDatabase
    @Published var items:[Item] = []
    @Published var usr:user = user()
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
//    func placeOrder(d:Array<Item>) -> <#return type#> {
//        <#function body#>
//    }
    func getUser(_ getAdmin:Bool = false) {
        if getAdmin {
                var temp = user()
                temp.id = nil
                temp.whishes = []
                temp.email = ""
                temp.accountStatus = ""
                //format: "schoolEmail == 'jsension7366@stu.d214.org'"
                let predicate = NSPredicate(value: true)

                let query = CKQuery(recordType: "account", predicate: predicate)
                //        let queryOperation = CKQueryOperation(query: query)
                //        var i:CKRecord.ID? = nil
                //        var w :[CKRecord.Reference] = []
                //        var e:String = ""
                //        var a:String = ""
                self.database.fetch(withQuery: query) { results in
                    //            print("start of fetch")

                    results.map {//var newItems:[Item] = []
                        $0.matchResults.map({$0.1.map { record in
                            //                    print("<STARTRECORD")
                            //                    print("------------------------")
                            //                    print("------------------------")
                            //                    print(record)
                            //                    newItems.append(Item(title: record["title"] as! String, description: record["description"] as! String, price: record["price"] as! Double, images: record["images"] as? [CKAsset] , id: record.recordID, reference: CKRecord.Reference.init(recordID: record.recordID, action: .none)))
                            //                                        i = record.recordID
                            //                                        e = record["schoolEmail"] as? String ?? ""
                            //                                        a = record["accountStatus"] as? String ?? ""
                            //                                        w = record["favouritedItems"] as? [CKRecord.Reference] ?? []
                            //                    Item(title: record["title"] as! String, description: record["description"] as! String, price: record["price"] as! Double, images: record["images"] as? [CKAsset] , id: record.recordID, reference: CKRecord.Reference.init(recordID: record.recordID, action: .none))
//                            if /*a != ""*/true {
                                print(record)
//                            }

                            //                    print("------------------------")
                            //                    print("------------------------")
                            //                    print("ENDRECORD>")
                        }})
                    }
                }
                //                    self.items = newItems
                //                self.id = i
                //                self.email = e
                //                self.accountStatus = a
                //                self.whishes = w
                //        print(self)
                //            print(results)
            }
            DispatchQueue.main.async {

            }
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
