import SwiftUI
import CloudKit

struct IndividualItemView: View {
//    var model:StateObject<ItemViewModel>
    @EnvironmentObject var model: ItemViewModel
    var curentItem:Item
    @State var showSizePicker = false
    @State var sizeNum = 0
    @State var col = 0
    @State var quantity:UInt = 1
    var styles: [blank] {
        get {
            var o: [blank] = []
            for i in sizes.keys {
                o.append(i)
            }
            return o
        }
    }
    @State var sizes: [blank:[blankSize]] = [:]
    @State var chosenStyle:Int = 0
    @State var chosenSize : Int = 0
    @State var activeReloading = false
    func reloadSizes() {
        if !activeReloading { activeReloading = true
            //            print(styles)
            //            print(sizes)
            sizes = [:]
            //            print(curentItem.record?.allKeys())
            let refs = curentItem.record["blanks"]! as? [CKRecord.Reference] ?? []
            //                    var innerLayer : [[CKRecord.Reference]] = []
            //                    var layer:[blank] = []
            //                    print("ref \(refs.count)")
            for ref in refs {

                CKContainer.default().publicCloudDatabase.fetch(withRecordID: ref.recordID) { record, e in
                    if record != nil {
                        let r = record.unsafelyUnwrapped
                        //                                print("we have an r")
                        //                                r["sizes"]
//                        var ta : [blankSize] = []
                        let i = blank(record: r)
                        sizes[i] = []
                        for ref in i.sizes {
                            CKContainer.default().publicCloudDatabase.fetch(withRecordID: ref.recordID) { record, e in
                                //                                            print(e)
                                if record != nil {
                                    let r = record.unsafelyUnwrapped
                                    //                                                print("we have an r2")
                                    //                                                r["sizes"]
                                    let g = blankSize(record: r)
                                    //                                                print(g)
                                    DispatchQueue.main.async {
                                        if sizes[i] == nil {sizes[i] = []}
                                        $sizes.wrappedValue[i]!.append(g)
                                        for _/*iie*/ in sizes.keys {
                                            //                                                    print("\(iie.name):")
//                                            for eei in sizes[iie]! {
//                                            }
                                        }
                                    }
                                }
                            }//refs
                            //                                    DispatchQueue.main.async {
                            //                                        styles.append(i)
                            //                                            sizes.wrappedValue[i]!.append(ta)

                            //                                        print("styles now has \(styles.count)")
                            //                                    }

                        }//pull
                    }//for

                }

            }
            //            print("done loading")
            activeReloading = false
        }
        //        sizes = []
        //        for (ai, a) in $styles.enumerated() {
        // //            print(styles.first!.record?.recordID)
        // //            print(a)
        //            var szs :[CKRecord.Reference] = []
        //            //            for b in a {
        //            //                a.wrappedValue.updateSelf()
        //            if a.record.wrappedValue != nil {
        //                let id = a.wrappedValue.record!.recordID
        //                //            wrappedValue.record!.recordID.self
        //                CKContainer.default().publicCloudDatabase.fetch(withRecordID: id) { record, error in
        //                    if record != nil {
        //                        var r:CKRecord {get {record.unsafelyUnwrapped}}
        //                        //                            a.wrappedValue.name = r["brandName"] as? String ?? a.wrappedValue.name
        //                        for i in r["sizes"] as? [CKRecord.Reference] ?? [] {
        //                            szs.append(i)
        //                            //                            }
        //                        }
        //                    }
        //                }
        //                var nextup:[blankSize] = []
        //                for (bi, b) in szs.enumerated() {
        //                    CKContainer.default().publicCloudDatabase.fetch(withRecordID: b.recordID) { record, error in
        //                            if record != nil {
        //                                var r:CKRecord {get {record.unsafelyUnwrapped}}
        //                                blankSize(shortName: "a", longName: "b", cost: 1, quantity: 1)
        //                                //                            a.wrappedValue.name = r["brandName"] as? String ?? a.wrappedValue.name
        //
        // //                                for i in r["sizes"] as? [CKRecord.Reference] ?? .init() {
        // //                                    szs.append(i)
        // //                                    //                            }
        // //                            }
        //                        }
        //                    }
        //                }
        //                sizes.append(/*bi = */nextup)
        //            }
        //        }
    }
    init (/*_ model:StateObject<ItemViewModel>, */item:Item) {
        curentItem = item
        //        trendingItems = []//model.wrappedValue.getTasks()
//        model.wrappedValue.update()
        
        //        model.wrappedValue.getUser()
//        self.model = model
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
    @State var navOpen = false
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            NavigationLink {
                HomeView(/*model*/)
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

                    DisplayImage(uiImage:previewImage)
                    //                    Image("hoodie_image") // Ensure image is in assets
                    //                        .resizable()
                    //                        .aspectRatio(contentMode: .fit)
                    //                        .frame(maxWidth: 500, maxHeight: 500)
                }.onTapGesture(count: 3) {
                    reloadSizes()
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
                        VStack{
                            if styles.count > chosenStyle {
                                Text(styles[chosenStyle].name)
                            } else {
                                Text("none selected")
                            }
                        }.foregroundStyle(.white).font(.caption)
                        HStack(spacing: 15) {
                            ForEach(0..<styles.count , id: \.self) { n in
                                Circle()
                                    .fill(styles[n].getCol())
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Circle()
                                            .stroke(chosenStyle == n ? Color.orange : Color.white, lineWidth: 2)
                                    )
                                    .onTapGesture {
//                                        print("stys")
//                                        print(self.styles.count)
//                                        print(sizes.count)
                                        if chosenStyle != n {
                                            chosenStyle = n //color
                                            chosenSize = 0
                                        }
//                                        reloadSizes()
                                    }
                            }
                        }
                    }
                    
                    Button(action: {
                        showSizePicker.toggle()
//                        reloadSizes()
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
                    
//                    if showSizePicker {&& (chosenStyle < styles.count && sizes[styles[chosenStyle]] != nil) {


                    // //////////////////
                    SizePicker(chosenStyle: chosenStyle, sizes: sizes, styles: styles, chosenSize: $chosenSize)



//                        Picker("Select Size", selection: $chosenSize) {
//
//                            if chosenStyle < styles.count {
//                                if sizes[styles[chosenStyle]] != nil {
//                                    ForEach(sizes[styles[chosenStyle]]!, id: \.self) { oo in
//
//
//                                        //                                let use = sizes[col][oo]
//                                        //                                Text(use.description)
//                                    }
//                                }
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .frame(width: 300)
                        
//                    }


                    HStack(spacing: 10) {
                        Button {
                            if chosenStyle < styles.count {
                                if sizes[styles[chosenStyle]] != nil {
                                    if chosenSize < sizes[styles[chosenStyle]]!.count {


//                                        orderItem(<#T##ref: Item##Item#>, <#T##qty: Int64##Int64#>, <#T##sty: blank##blank#>, <#T##selected: blankSize##blankSize#>)

                                        model.order.append(orderItem.init(curentItem, styles[chosenStyle], sizes[styles[chosenStyle]]![chosenSize]))
                                        navOpen = true
                                    }
                                }
                            }
                        } label: {
                            ZStack {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.orange)
                                        .frame(width: 300, height: 50)
                                    Text("Add to cart - \(toPrice(curentItem.price))")
                                        .font(Font.custom("Lexend", size: 16))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .navigationDestination(isPresented: $navOpen, destination: {
                            if chosenStyle < styles.count {
                            if sizes[styles[chosenStyle]] != nil {
                                if chosenSize < sizes[styles[chosenStyle]]!.count {
                                    let sty = styles[chosenStyle]

                                    CartView(nyItem: orderItem(curentItem, sty, sizes[sty]![chosenSize]))
                                }

                            }
                        }
                        })

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

    }
}
struct DisplayImage: View {
    var uiImage: UIImage
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.gray)
            Image(uiImage:uiImage) //item.images)
                .resizable()
                .padding(.all)
        }
        .frame(width: 468, height: 512)
        .cornerRadius(8)
    }
}
