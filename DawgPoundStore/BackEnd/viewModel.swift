//
//  viewModel.swift
//  DawgPoundStore
//
//  Created by John Sencion on 5/12/25.
//
import SwiftUI
import SwiftData
import CloudKit
//@Model
@MainActor
//@Observable
class ItemViewModel: ObservableObject {
    var navPath: NavigationPath = NavigationPath.init()
    init() {
        self.usr.email = "jsencion7366@stu.d214.org"
    }
    func qryItm(recordID: CKRecord.ID) -> Item? {
        var ret = nil as Item?
        self.database.fetch(withRecordID: recordID) { r,e in
            if let record = r {
                ret = Item(record)
            }
        }
        return ret
    }
    public let database = CKContainer.default().publicCloudDatabase
    var maintenanceFee : Int = 800
    //    @Published var items:[Item] = []
    /*@Published */var usr:user = user()
    @Published var order:[orderItem] = []
    //    @Published var cart:[orderItem] = []
    //Gone until further notice    /*@Published */var orders:[orderItem] = []
    /*@Published */@AppStorage("username") var userCookie : String = "ADMIN"
    /*@Published */var homeColecs:[ic] = []
    /*@Published */var timedown:Int = 0
    private var isRequesting = false

    @Published var JDebugMode:Bool = false

    func update(_ force:Bool = false) {
        //items.isEmpty
        //            print("START OF REQUESTS")
        getTasks()
        //           int("tasks received")
        getUser(userCookie)
        //           int("user received")
        getActiveCart()
        //            print("activeCart received")
        getCollections()
        //            print("collections received\ncollections received")
    }
    func getCollections() {
        let homeRecordNames: [String] = [
            "7D64CC49-2D7C-4191-A987-063BD0D9DF15"
        ]

        for i in homeRecordNames{
            self.database.fetch(withQuery: .init(recordType: "itemCollection", predicate: .init(format: "___recordID == %@",CKRecord.ID(recordName: i)))) { [self] results in
                //                                print(results)
                let _ = results.map { (matchResults: [(CKRecord.ID, Result<CKRecord, any Error>)], queryCursor: CKQueryOperation.Cursor?) in
                    if matchResults.count > 0{
                        let uperUse = matchResults.first!.1
                        let _ = uperUse.map { r in
                            DispatchQueue.main.async {
                                //                                print()
                                var use = true
                                for i in self.homeColecs {
                                    if i == .init(r) {
                                        use = false
                                    }
                                }
                                if use {
                                    var touse:ic = .init(name: "Err", desc: "err", itemRefs: [])
                                    DispatchQueue.main.async {
                                        touse = .init(r)
                                    }
                                    DispatchQueue.main.async{

                                        self.homeColecs.append(touse)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            //            print("go")

        }
//        let sideRecordNames: [String] = [
//            "8032DBAA-2AAD-4597-AFF7-E2D8F42D3CD5"
//        ]
    }
    func addTask(taskItem: inout Item) {

        let record = CKRecord(recordType: "Item")
        taskItem.record = record
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
        qryItm(recordID: id.recordID)
        //        for i in items {
        //            if i.id  == id.recordID {
        //                return i
        //            }
        //        }
        //        return nil
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
            let _ = results.map {
                $0.matchResults.map{let _ = $0.1.map { record in

                    //                    temp.email
                    //                    temp.accountStatus
                    //                    temp.accountStatus
                    temp.id = record.recordID

                    for iter in record["cart"] as! [CKRecord.Reference] {
                        //                        database.

                        //                        print("recordName == '\(iter.recordID.recordName)'")//"iter.recordID.recordName.self)
                        //                        let q = CKQuery(recordType: "Item", predicate: NSPredicate(format: "___recordID == %@", iter.recordID))
                        //                        print("\(q.recordType);  \(q.predicate)")
                        self.self.self.self.self.database.fetch(withRecordID: iter.recordID) { r,e in
                            //                            print("map0")
                            //                            print(e)
                            if r == nil {
                                print("sad :(")
                            } else {
                                // get User Orders
                                //                                }
                            }

                        }

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

            let _ = results.map {//var newItems:[Item] = []
                let _ = $0.matchResults.map({let _ = $0.1.map { record in
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
    ///depreciated
    func getTasks() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Item", predicate: predicate)
        //        let queryOperation = CKQueryOperation(query: query)
        database.fetch(withQuery: query) { results in
            //            print("start of fetch")

            let _ = results.map {var newItems:[Item] = []
                let _ = $0.matchResults.map({let _ = $0.1.map { record in
                    //                print("<STARTRECORD")
                    //                print("------------------------")
                    //                print("------------------------")
                    //                print(record)
                    newItems.append(Item(record))
                    //                print("------------------------")
                    //                print("------------------------")
                    //                print("ENDRECORD>")
                }})
                //                DispatchQueue.main.async {
                //                    self.items = newItems
                //                }
            }
            //            print(results)
        }

        //        queryOperation.queryResultBlock = { results in
        //            print(results)
        //        }
    }
}
