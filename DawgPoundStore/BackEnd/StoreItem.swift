//
//  StoreItem.swift
//  DawgPoundStore
//
//  Created by John Sencion on 12/13/24.
//

import SwiftUI
import CloudKit


struct Item:Identifiable, Hashable/*, Codable*/ {
    var id: CKRecord.ID?
    var title:String
    var description:String
var images:[CKAsset]?
    var price:Double
    init(title: String, description: String, price: Double, images: [CKAsset]? = [], id: CKRecord.ID? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.images = images
        self.price = price
    }
    init(_ title: String, _ description: String, _ price: Double, images: [CKAsset]? = [], id: CKRecord.ID? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.images = images
        self.price = price
    }
}
///ready to sell object
@MainActor
class ItemViewModel: ObservableObject {
    var database = CKContainer.default().publicCloudDatabase
    @Published var items:[Item] = []
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

    func getTasks() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Item", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        database.fetch(withQuery: query) { results in
            print("start of fetch")

            results.map {var newItems:[Item] = []
                $0.matchResults.map({$0.1.map { record in
                print("<STARTRECORD")
                print("------------------------")
                print("------------------------")
                print(record)
                newItems.append(Item(title: record["title"] as! String, description: record["description"] as! String, price: record["price"] as! Double, images: record["images"] as? [CKAsset] , id: record.recordID))
                print("------------------------")
                print("------------------------")
                print("ENDRECORD>")
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
