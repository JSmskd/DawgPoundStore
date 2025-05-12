//
//  itemStuff.swift
//  DawgPoundStore
//
//  Created by John Sencion on 5/12/25.
//
import CloudKit
import SwiftUI
import SwiftData

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
        //fetch(withRecordID: reference) { record, error in
        price = p
        quantity = qty
        name = longname
        n = shortname
        record = rec
    }
    //    init (_ reference:CKRecord.Reference) {
    //        "".first! as! String
    //        var shortname = ""
    //        var longname = ""
    //        var price = 0
    //        var qty = 0
    //        var rec = CKRecord(recordType: "blankSIZE", recordID: reference.recordID)
    //        CKContainer.default().publicCloudDatabase.fetch(withRecordID: reference.recordID) { record, e in
    //            rec = record ?? CKRecord(recordType: "blankSIZE", recordID: reference.recordID)
    //            if record != nil {
    //                let r = record.unsafelyUnwrapped
    //
    //                shortname =  r["shortName"] as? String ?? "err"
    //                longname = r["longName"] as? String ?? "error"
    //                qty = r["quantity"] as? Int ?? 0
    //                price = r["cost"] as? Int ?? 0
    //            }
    //
    //        }
    //        //fetch(withRecordID: reference) { record, error in
    //        record = rec
    //        cost = price
    //        quantity = qty
    //        name = longname
    //        n = shortname
    //    }
    init (record r : CKRecord) {
        record = r
        n =  r["shortName"] as? String ?? "err"
        name = r["longName"] as? String ?? "error"
        quantity = r["quantity"] as? Int ?? 0
        price = Int(truncatingIfNeeded:r["cost"] as? Int ?? 0)
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
        //        print("new blank")
        //["color", "sizes", "brandName"]
        record = r
        name = r["color"] as! String
        //        print(r["color"] == nil)
        sizes = r["sizes"] as! [CKRecord.Reference]
        //        print(r["sizes"])
        price = Int(truncatingIfNeeded: r["cost"] as? Int64 ?? 0)
    }
    //    init(_ reference:CKRecord.ID) {
    //        var NAME = "error"
    //        var szs :[CKRecord.Reference] = []
    //        name = "error" //NAME
    //        sizes = [CKRecord.Reference].init() //szs
    //    }
}
struct orderItem:Identifiable, Hashable {
    var id:CKRecord.Reference?
    var item:Item//price
    var quantity:Int64
    var style:blank//
    var blnk:blankSize//price
    init (_ ref:Item,_ qty:Int64, _ sty:blank, id:CKRecord.Reference? = nil, _ selected:blankSize) {
        //            itm = Item(reference: ref)
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
    //    var previewImage:UIImage? { get {
    //        item.images!.first!.fileURL
    //        return
    //    }}
    //    var model:StateObject<ItemViewModel>
    @EnvironmentObject var model: ItemViewModel
    init (_ model:StateObject<ItemViewModel>? = nil, item:Item) {
        self.item = item
        //        trendingItems = []//model.wrappedValue.getTasks()
        //        if model.wrappedValue.items.isEmpty {
        //            model.wrappedValue.update()
        //        DispatchQueue.main.async {
        //            model.wrappedValue.timedown -= 0
        //        }
        //        }

        //        model.wrappedValue.getUser()
        //        self.model = model
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
                    //                    .onAppear {
                    ////                        item.images!.first!.fileURL
                    ////                        print(<#T##items: Any...##Any#>)
                    ////                        print("hi")
                    ////                        print(item.images?.first?.fileURL)
                    //                    }
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
