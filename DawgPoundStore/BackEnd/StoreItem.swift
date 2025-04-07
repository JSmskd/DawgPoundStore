//
//  StoreItem.swift
//  DawgPoundStore
//
//  Created by John Sencion on 12/13/24.
//

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
        email = ""
        accountStatus = ""
        itemsInCart = []
    }
}
struct blankSize:Hashable {
    var name:String
    var n:String
    ///cost multiplied my 10000 {10.423  ->  10423}
    var cost:Int
    var quantity:Int
    var record:CKRecord?
    init (shortName:String,longName:String,cost:Int,quantity:Int) {
        self.cost = cost
        self.quantity = quantity
        self.name = longName
        self.n = shortName
    }
    mutating func updateSelf () {
        if record?.recordID == nil { print("fail"); return}
        var shortname = ""
        var longname = ""
        var price = 0
        var qty = 0
        var rec = record
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: record.unsafelyUnwrapped.recordID) { record, e in

            if record != nil {
                rec = record.unsafelyUnwrapped
                let r = record.unsafelyUnwrapped

                shortname =  r["shortName"] as? String ?? "err"
                longname = r["longName"] as? String ?? "error"
                qty = r["quantity"] as? Int ?? 0
                price = r["cost"] as? Int ?? 0
            }

        }
        //fetch(withRecordID: reference) { record, error in
        cost = price
        quantity = qty
        name = longname
        n = shortname
        record = rec
    }
    init (_ reference:CKRecord.Reference) {
        var shortname = ""
        var longname = ""
        var price = 0
        var qty = 0
        var rec = CKRecord(recordType: "blankSIZE", recordID: reference.recordID)
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: reference.recordID) { record, e in
            rec = record ?? CKRecord(recordType: "blankSIZE", recordID: reference.recordID)
            if record != nil {
                let r = record.unsafelyUnwrapped

                shortname =  r["shortName"] as? String ?? "err"
                longname = r["longName"] as? String ?? "error"
                qty = r["quantity"] as? Int ?? 0
                price = r["cost"] as? Int ?? 0
            }

        }
        //fetch(withRecordID: reference) { record, error in
        record = rec
        cost = price
        quantity = qty
        name = longname
        n = shortname
    }
}
struct blank:CustomStringConvertible , Hashable{
    var name:String

    var sizes:[CKRecord.Reference]
    var record:CKRecord?
    var description: String {get {name}}
    init (name:String,sizes:[CKRecord.Reference], record:CKRecord? = nil) {
        self.name = name
        self.sizes = sizes
        self.record = record
    }
    init(_ reference:CKRecord.ID) {
        var NAME = "error"
        var szs :[CKRecord.Reference] = []
        name = NAME
        sizes = szs
    }
}
struct orderItem:Identifiable, Hashable {
    var id:CKRecord.Reference?
    var item:Item
    var quantity:Int64
    var style:blank
    var blnk:blankSize
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
    var model:StateObject<ItemViewModel>
    init (_ model:StateObject<ItemViewModel>, item:Item) {
        self.item = item
        //        trendingItems = []//model.wrappedValue.getTasks()
//        if model.wrappedValue.items.isEmpty {
//            model.wrappedValue.update()
//        DispatchQueue.main.async {
//            model.wrappedValue.timedown -= 0
//        }
//        }

        //        model.wrappedValue.getUser()
        self.model = model
    }
    var body: some View {
        VStack{
            NavigationLink {
                IndividualItemView(model, item: item)
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
@MainActor
class ItemViewModel: ObservableObject {
    
    func qryItm(recordID: CKRecord.ID) -> Item? {
        var ret = nil as Item?
        self.database.fetch(withRecordID: recordID) { r,e in
            if let record = r {
                ret = Item(title: record["title"] as! String, description: record["description"] as! String, price: record["price"] as! Int, images: record["images"] as? [CKAsset] , id: record, reference: CKRecord.Reference.init(recordID: record.recordID, action: .none))
            }
        }
        return ret
    }
    var database = CKContainer.default().publicCloudDatabase
//    @Published var items:[Item] = []
    @Published var usr:user = user()
    @Published var cart:[orderItem] = []
    @Published var orders:[orderItem] = []
    @Published var userCookie : String = "ADMIN"
    @Published var homeColecs:[ic] = []
    @Published var timedown:Int = 0
    private var isRequesting = false

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
                results.map { (matchResults: [(CKRecord.ID, Result<CKRecord, any Error>)], queryCursor: CKQueryOperation.Cursor?) in
                    if matchResults.count > 0{
                        let uperUse = matchResults.first!.1
                        uperUse.map { r in
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
//                                        print(touse.desc)
//                                        print("inners")
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
        let sideRecordNames: [String] = [
            "8032DBAA-2AAD-4597-AFF7-E2D8F42D3CD5"
        ]
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
            results.map {
                //                var name = ""
                                var newItems:[Item] = []
                $0.matchResults.map{$0.1.map { record in

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
//                                print(r!)
//                                print(r!.allKeys())
//                                print(r!["quantity"] as! Int64)
//                                print(r!["style"] as! String)
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
    ///depreciated
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
                    newItems.append(Item(title: record["title"] as! String, description: record["description"] as! String, price: /*record["price"] as! Int*/0, images: record["images"] as? [CKAsset] , id: record, reference: CKRecord.Reference.init(recordID: record.recordID, action: .none)))
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
