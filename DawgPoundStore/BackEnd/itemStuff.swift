//
//  itemStuff.swift
//  DawgPoundStore
//
//  Created by John Sencion on 5/12/25.
//
import CloudKit
import SwiftUI
import SwiftData
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
struct orderItem:Identifiable, Hashable {
    var id:CKRecord.Reference?
    var item:Item
    var quantity:Int64
    var style:blank
    var blnk:blankSize
    init (_ ref:Item,_ qty:Int64, _ sty:blank, id:CKRecord.Reference? = nil, _ selected:blankSize) {
        quantity = qty
        style = sty
        item = ref
        blnk = selected
    }
}

struct Item:Identifiable, CustomStringConvertible, Hashable/*, Codable*/ {
    var description: String {
        return "\(title) : \(price)"
    }
    var id: CKRecord.ID? {get {
        record?.recordID
    }}
    var record:CKRecord?
    var title:String
    var Itemdescription:String
    var reference:CKRecord.Reference?
    var images:[CKAsset]?
    var price:Int
    //    var dollar:Int {get {price / 100}}
    //    var cent:Int {get {price - (dollar * 1000)}}
    init(title: String, description: String, price: Int, images: [CKAsset]? = [], id: CKRecord? = nil,reference: CKRecord.Reference? = nil) {
        self.record = id
        self.title = title
        self.Itemdescription = description
        self.images = images
        self.price = price
        self.reference = reference
    }
    init(_ title: String, _ description: String, _ price: Int, images: [CKAsset]? = [], id: CKRecord? = nil, reference: CKRecord.Reference? = nil) {
        self.record = id
        self.title = title
        self.Itemdescription = description
        self.images = images
        self.price = price
        self.reference = reference
    }
}

struct blank:CustomStringConvertible , Hashable, Identifiable{
    var id : Int { get { hashValue}}
    var name:String
    func getCol() -> Color {
        switch name {
            case "orange":
                return .orange
            case "white":
                return .white
            default:
                return.clear
        }
    }
    var sizes:[CKRecord.Reference]
    var record:CKRecord?
    var price:Int
    var description: String {get {name}}
    init (name:String,sizes:[CKRecord.Reference], record:CKRecord? = nil) {
        self.name = name
        self.sizes = sizes
        self.record = record
        price = 0
    }
    init(record r:CKRecord) {
        record = r
        name = r["color"] as! String
        sizes = r["sizes"] as! [CKRecord.Reference]
        price = Int(truncatingIfNeeded: r["cost"] as? Int64 ?? 0)
    }
}



struct blankSize:Hashable, Identifiable, CustomStringConvertible {
    var description: String {get {name}}
    var id : Int { get { hashValue}}
    var name:String
    var n:String
    ///cost multiplied my 10000 {10.423  ->  10423}
    var price:Int
    var quantity:Int
    var record:CKRecord?
    init (shortName:String,longName:String,cost:Int,quantity:Int) {
        self.price = cost
        self.quantity = quantity
        self.name = longName
        self.n = shortName
    }
    mutating func updateSelf () {
        if record?.recordID == nil { print("fail"); return}
        var shortname = ""
        var longname = ""
        var p = 0
        var qty = 0
        var rec = record
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: record.unsafelyUnwrapped.recordID) { record, e in

            if record != nil {
                rec = record.unsafelyUnwrapped
                let r = record.unsafelyUnwrapped

                shortname =  r["shortName"] as? String ?? "err"
                longname = r["longName"] as? String ?? "error"
                qty = r["quantity"] as? Int ?? 0
                p = r["cost"] as? Int ?? 0
            }

        }
        price = p
        quantity = qty
        name = longname
        n = shortname
        record = rec
    }
    init (record r : CKRecord) {
        record = r
        n =  r["shortName"] as? String ?? "err"
        name = r["longName"] as? String ?? "error"
        quantity = r["quantity"] as? Int ?? 0
        price = Int(truncatingIfNeeded:r["cost"] as? Int ?? 0)
    }
}


struct itemPreview:View {
    var item:Item
    var previewImage:UIImage { get {
        var ret:UIImage = .dawgPoundLogo
        if item.images != nil { if item.images!.first != nil { if item.images!.first!.fileURL != nil {
            ret = UIImage.init(data:NSData(contentsOf: item.images!.first!.fileURL.unsafelyUnwrapped.absoluteURL)! as Data) ?? ret
        } } }
        return ret
    }
    }

    @EnvironmentObject var model: ItemViewModel
    init (_ model:StateObject<ItemViewModel>? = nil, item:Item) {
        self.item = item
    }
    var body: some View {
        VStack{
            NavigationLink {
                IndividualItemView(/*model, */item: item)
            } label: {
                VStack {
                    ZStack{
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 140, height: 140)
                            .cornerRadius(8)
                        Image(uiImage:previewImage) //item.images)
                            .resizable()
                    }
                    .frame(width: 140, height: 140)
                    .cornerRadius(8)
                    Text(item.title)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.top, 5)

                    Text(toPrice(item.price))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .frame(width: 140, height: 160)
            }
        }
    }
}
