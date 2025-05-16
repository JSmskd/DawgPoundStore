//
//  JMenu.swift
//  DawgPoundStore
//
//  Created by John Sencion on 5/12/25.
//

import SwiftUI
import CloudKit

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
            NavigationLink {
                VOrder()
            } label: {
                Text("View Orders")
            }

            //            HStack {
            //                Button("Lock Time") {
            //
            //                }
            //            }



        }
    }
}

struct VOrder: View {
    @EnvironmentObject var model : ItemViewModel
    @State var orders:[order] = []
    var body: some View {
        Button("ref") {
            refreshShirts()
        }
        ForEach($orders, id:\.self) { i in
            NavigationLink {
                VOI(ind:i)
            } label: {
                Text(i.wrappedValue.record.recordID.recordName)
            }

        }
    }
    func refreshShirts() {
        orders = []

        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Order", predicate: predicate)
        //        let queryOperation = CKQueryOperation(query: query)
        var newItems:[order] = []
        model.database.fetch(withQuery: query) { results in
            print("start of fetch")

            results.map {
                $0.matchResults.map({$0.1.map { record in
                    newItems.append(order(record))
                    //                    print("newItem")

                }
                })
            }

        }
        $orders.wrappedValue = newItems
    }
}
struct VOI: View {
    @EnvironmentObject var model : ItemViewModel
    @Binding var ind:order
    @State var tims:[orderItem] = []
    var body: some View {
        List{

            ForEach(tims) { t in
                VStack{
                    Text(t.item.description)
                    Text(t.blnk.description)
                    Text(t.style.description)
                }
            }
        }
    }
    func getItems() {
        tims = []
        let db = model.database
        for o in ind.itemsOrdered {
            print(o.recordID)
            //get the orderItem
            db.fetch(withRecordID: o.recordID) { record, error in
                if record != nil {
                    print("itemOrder")
                    var r:CKRecord = record.unsafelyUnwrapped
                    //                            a.wrappedValue.name = r["brandName"] as? String ?? a.wrappedValue.name


                    //                    r["quantity"] as? Int64 ?? 0
                    ///item

                    var i:Item?
                    print(o.recordID)
                    //item of orderItem
                    db.fetch(withRecordID: o.recordID) { record, error in
                        if record != nil {
                            print("item")
                            var r:CKRecord = record.unsafelyUnwrapped
                            i = Item.init(title: r["title"] as? String ?? "CAN NOT GET", description: r["description"] as? String ?? "CAN NOT GET", price: Int(r["cost"] as? Int64 ?? 0), images: nil, id: r, reference: nil)
                            //                            i = .init(record: r)
                            ///blank
                            var b:blank?
                            db.fetch(withRecordID: o.recordID) { record, error in
                                if record != nil {
                                    print("blank")
                                    var r:CKRecord = record.unsafelyUnwrapped
                                    b = .init(record: r)
                                    ///blankSize
                                    var s:blankSize?
                                    db.fetch(withRecordID: o.recordID) { record, error in
                                        if record != nil {
                                            print("size")
                                            var r:CKRecord = record.unsafelyUnwrapped
                                            s = .init(record: r)
                                            if i != nil && b != nil && s != nil {
                                                print("all good")
                                                tims.append(orderItem.init(i!, r["quantity"] as? Int64 ?? 0, b!, id: nil, s!))
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

            }
        }
    }
}
struct order:Hashable/*:Identifiable*/ {
    //    var id: CKRecord.Reference = .init(record: "Order", action: .none)
    var record:CKRecord
    var itemsOrdered:[CKRecord.Reference] {get {
        record["itemsOrdered"] as? [CKRecord.Reference] ?? []
    } set {
        record["itemsOrdered"] = newValue
    }}
    var orderFulfilledBy:String {get {
        record["orderFulfilledBy"] as? String ?? "ERR"
    } set {
        record["orderFulfilledBy"] = newValue
    }}
    var pickupIdentifier: String {get {
        record["pickupIdentifier"] as? String ?? "ERR"
    } set {
        record["pickupIdentifier"] = newValue
    }}
    init(_ r:CKRecord) {
        //        id = ref
        record = r
        //        print(r)
    }
    static func == (lhs: order, rhs: order) -> Bool {
        lhs.record.recordID == rhs.record.recordID
    }
}
