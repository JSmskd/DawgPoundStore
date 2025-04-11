import SwiftUI
import CloudKit

struct IndividualItemView: View {
    var model:StateObject<ItemViewModel>
    var curentItem:Item
    @State var showSizePicker = false
    @State var sizeNum = 0
    @State var col = 0
    @State var quantity:UInt = 1
    @State var styles: [blank] = [
        .init(CKRecord.ID.init(recordName: "FA9FAB4D-F49F-4B26-B365-7F3210C8D9EE")),
        .init(CKRecord.ID.init(recordName: "CE24806E-343D-4D68-9067-A80895D834FF"))
    ]
    @State var sizes: [[blankSize]] = [
        [
            blankSize.init(CKRecord.Reference.init(recordID: .init(recordName: "478BD526-5E40-4ACD-89AC-EAB617929B61"), action: CKRecord.ReferenceAction.none)),
                           blankSize.init(CKRecord.Reference.init(recordID: .init(recordName: "80EDAE9C-6396-4F9D-B4D2-F906794C8526"), action: CKRecord.ReferenceAction.none))
        ],
        [
            blankSize.init(CKRecord.Reference.init(recordID: .init(recordName: "73F4CFC6-745B-4DDD-ABAA-5042E6F9F0FE"), action: CKRecord.ReferenceAction.none))
        ]
    ]
    func reloadSizes() {
        sizes = []
        for (ai, a) in $styles.enumerated() {
//            print(styles.first!.record?.recordID)
//            print(a)
            var szs :[CKRecord.Reference] = []
            //            for b in a {
            //                a.wrappedValue.updateSelf()
            if a.record.wrappedValue != nil {
                let id = a.wrappedValue.record!.recordID
                //            wrappedValue.record!.recordID.self
                CKContainer.default().publicCloudDatabase.fetch(withRecordID: id) { record, error in
                    if record != nil {
                        var r:CKRecord {get {record.unsafelyUnwrapped}}
                        //                            a.wrappedValue.name = r["brandName"] as? String ?? a.wrappedValue.name
                        for i in r["sizes"] as? [CKRecord.Reference] ?? [] {
                            szs.append(i)
                            //                            }
                        }
                    }
                }
                var nextup:[blankSize] = []
                for (bi, b) in szs.enumerated() {
                    CKContainer.default().publicCloudDatabase.fetch(withRecordID: b.recordID) { record, error in
                            if record != nil {
                                var r:CKRecord {get {record.unsafelyUnwrapped}}
                                blankSize(shortName: "a", longName: "b", cost: 1, quantity: 1)
                                //                            a.wrappedValue.name = r["brandName"] as? String ?? a.wrappedValue.name

//                                for i in r["sizes"] as? [CKRecord.Reference] ?? .init() {
//                                    szs.append(i)
//                                    //                            }
//                            }
                        }
                    }
                }
                sizes.append(/*bi = */nextup)
            }
        }
    }
    init (_ model:StateObject<ItemViewModel>, item:Item) {
        curentItem = item
        //        trendingItems = []//model.wrappedValue.getTasks()
            model.wrappedValue.update()

        //        model.wrappedValue.getUser()
        self.model = model
//        item.reference?.recordID ?? .init(recordName: "F527E4A8-2B46-4930-8535-D51E6CCDC31B")

    }
//    @State private var selectedColor: Color = .gray
//    @State private var selectedSize: String? = nil
//    @State private var showSizePicker = false
//    @State private var isFavorite = false

    let colors: [Color] = [.white, Color(red: 0.43, green: 0.33, blue: 0.24), .gray]
//    let sizes: [String] = ["S", "M", "L", "XL", "XXL"]
    var previewImage:UIImage { get {
        var ret:UIImage = .dawgPoundLogo
        if curentItem.images != nil { if curentItem.images!.first != nil { if curentItem.images!.first!.fileURL != nil {
            ret = UIImage.init(data:NSData(contentsOf: curentItem.images!.first!.fileURL.unsafelyUnwrapped.absoluteURL)! as Data) ?? ret
        } } }
        return ret
    }
    }
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            NavigationLink {
                HomeView(model)
            } label:
            {
                Image("DawgPoundLogo")
                    .resizable()
                    .frame(width:80, height: 80)
                    .aspectRatio(1.0, contentMode: .fit)
//                    .position(x: UIScreen.main.bounds.width / 2, y: 70)


            }
            .frame(width:80, height: 80)
            .aspectRatio(1.0, contentMode: .fit)
            .position(x: UIScreen.main.bounds.width / 2, y: 48)
            HStack(spacing: 30) {
                VStack {
                    ZStack{
                        Rectangle()
                            .fill(Color.gray)
                        Image(uiImage:previewImage) //item.images)
                            .resizable()
                            .padding(.all)
                    }
                    .frame(width: 468, height: 512)
                .cornerRadius(8)
//                    Image("hoodie_image") // Ensure image is in assets
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(maxWidth: 500, maxHeight: 500)
                }

                VStack(alignment: .leading, spacing: 20) {
                    Text("DAWG\nPOUND")
                        .font(Font.custom("Lexend", size: 36).weight(.bold))
                        .foregroundColor(Color(red: 1.0, green: 0.4, blue: 0.11))

                    Spacer().frame(height: 11)

                    Text("Independent Trading Co.")
                        .font(Font.custom("Lexend", size: 16).weight(.light))
                        .foregroundColor(.white)

                    Text("\(curentItem.title)")
                        .font(Font.custom("Lexend", size: 24).weight(.semibold))
                        .foregroundColor(.white)

                    Text("\(curentItem.Itemdescription )")
                        .font(Font.custom("Lexend", size: 14).weight(.light))
                        .foregroundColor(.white)

                    Text("\(toPrice(curentItem.price))")
                        .font(Font.custom("Lexend", size: 24))
                        .foregroundColor(.white)

                    VStack(alignment: .leading) {
                        Text("Color")
                            .font(Font.custom("Lexend-Bold", size: 16).weight(.light))
                            .foregroundColor(.white)

//                        HStack(spacing: 15) {
//                            ForEach(colors, id: \.self) { color in
//                                Circle()
//                                    .fill(color)
//                                    .frame(width: 30, height: 30)
//                                    .overlay(
//                                        Circle()
//                                            .stroke(selectedColor == color ? Color.orange : Color.white, lineWidth: 2)
//                                    )
//                                    .onTapGesture {
//                                        selectedColor = color
//                                    }
//                            }
//                        }
                    }

                    Button(action: {
                        showSizePicker.toggle()
                        reloadSizes()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 300, height: 50)

                            HStack {
                                Text(/*selectedSize ?? */"Select a Size")
                                    .font(Font.custom("Lexend", size: 16))
                                    .foregroundColor(.white)

                                Image(systemName: "chevron.down")
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                        }
                    }

                    if showSizePicker {
                        Picker("Select Size", selection: $sizeNum) {
//                            ForEach(0..<sizes[col].count, id: \.self) { oo in
//                                Text("\(sizes[col][oo].name )").tag(oo)
//                                let use = sizes[col][oo]
//                                Text(use.description)
//                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 300)

                    }

                    HStack(spacing: 10) {
                        Button(action: {
                            // Add to cart functionality

                            print(curentItem)

                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.orange)
                                    .frame(width: 300, height: 50)

//                                NavigationLink {
//                                    CartView(model, items: [.init(curentItem, Int64(exactly: quantity)!, styles.first!, sizes.first!.first! )])
//                                } label: {
                                    Text("Add to cart - \(toPrice(curentItem.price))")
                                        .font(Font.custom("Lexend", size: 16))
                                        .foregroundColor(.white)
//                                }

                            }
                        }

                        Button(action: {
//                            isFavorite.toggle()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.orange, lineWidth: 1)
                                    .frame(width: 50, height: 50)

                                Image(systemName: /*isFavorite ? "heart.fill" : */"heart")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .frame(maxWidth: 500)
                .padding()
            }
        

                   

                              Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .onAppear {
                    reloadSizes()
                }
                .onTapGesture {
                    print(sizes)
                    print(styles)
                }
            }
        }
    

//struct HoodieView_Previews: PreviewProvider {
//    static var previews: some View {
//        IndividualItemView()
//    }
//}
