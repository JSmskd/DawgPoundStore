//
//  itemStuff.swift
//  DawgPoundStore
//
//  Created by John Sencion on 5/12/25.
//
import CloudKit
import SwiftUI
import SwiftData
struct order:JSRecord {
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
struct orderItem:JSRecord {
    
    var record: CKRecord
    
//    var id:CKRecord.Reference
    var item:Item
    var quantity:Int64 { get {record["quantity"] as? Int64 ??  1} set {record["quantity"] = newValue}}
    var style:blank
    var blnk:blankSize
    init (_ rec:CKRecord,_ ref:Item, _ sty:blank, _ selected:blankSize) {
        style = sty
        item = ref
        blnk = selected
        record = rec
    }
    init (_ ref:Item, _ sty:blank, _ selected:blankSize) {
        style = sty
        item = ref
        blnk = selected
        record = CKRecord.init(recordType: "orderItem")
        record.setValue(1, forKey: "quantity")
    }
}

struct Item:JSRecord {

    var record: CKRecord
    
    var description: String {
        return "\(title) : \(price)"
    }

    var title:String { get {record["title"] as? String ?? "" } set {record["title"] = newValue}}
    var Itemdescription:String { get { record["description"] as? String ?? ""} set{record["description"] = newValue}}
    var images:[CKAsset]? { get { record["images"] as? Array<CKAsset>}}
    var price:Int { get { (record["cost"] as? Int ?? -1)} set {record["cost"] = newValue}}
    //    var dollar:Int {get {price / 100}}
    //    var cent:Int {get {price - (dollar * 1000)}}
//    init(title: String, description: String, price: Int, images: [CKAsset]? = [], id: CKRecord? = nil,reference: CKRecord.Reference? = nil) {
//        self.title = title
//        self.Itemdescription = description
//        self.images = images
//        self.price = price
//        self.reference = reference
//    }
//    init(_ title: String, _ description: String, _ price: Int, images: [CKAsset]? = [], id: CKRecord? = nil, reference: CKRecord.Reference? = nil) {
//        self.title = title
//        self.Itemdescription = description
//        self.images = images
//        self.price = price
//        self.reference = reference
//    }
    init (_ record:CKRecord) {
        self.record = record
    }
}

struct blank:JSRecord{

    var record: CKRecord
    
//    var id : Int { get { hashValue}}
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
    var price:Int
    var description: String {get {name}}
    init (name:String,sizes:[CKRecord.Reference], record:CKRecord) {
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



struct blankSize:JSRecord {
    var record: CKRecord
    
    var description: String {get {name}}

    var name:String { get { record["longName"] as? String ?? "error"}}
    var n:String { get { record["shortName"] as? String ?? "err"}}
    ///cost multiplied my 10000 {10.423  ->  10423}
    var price:Int { get { Int(truncatingIfNeeded:record["cost"] as? Int ?? 0)}}
    var quantity:Int { get {record["quantity"] as? Int ?? 0 }}
    mutating func updateSelf () {
        var rec = record
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: record.recordID) { record, e in
            if record != nil { rec = record.unsafelyUnwrapped }
        }
        record = rec
    }
    init (record r : CKRecord) {
        record = r
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
