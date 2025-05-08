import SwiftUI
import CloudKit
struct FinalView: View {
//    var model:StateObject<ItemViewModel>
    @EnvironmentObject var model: ItemViewModel
    init (/*_ model:StateObject<ItemViewModel>*/) {
//        self.model = model
    }
    @State var fin:Bool = false
    var body: some View {
        Text("Thank you for ordering!")
            .font(.custom("Lexend-Regular", size: 24))
            .padding()
            .onAppear {
                var total:[CKRecord.Reference] = []
                for r in model.cart {
                    var o:CKRecord = .init(recordType: "orderItem")
                    o.setObject(r.item.reference!, forKey: "Item")//reference
                    o.setObject(r.quantity as __CKRecordObjCValue, forKey: "quantity")
//                    o.setObject(r.blnk.record!.recordID.recordName, forKey: "blankSize")//refrence
//                    o.setObject("", forKey: "style")//String
                    let x = CKRecord.Reference.init(record: o, action:.none)
                    print(x)
                    total.append(x)
                    model.database.save(o, completionHandler: { _, _ in
                    })
                }
                var o:CKRecord = .init(recordType: "Order")
                DispatchQueue.main.schedule {
                    model.database.save(o, completionHandler: { _, _ in
                    })
                }
            }
        ZStack {
            Rectangle()
                .foregroundStyle(Color.gray.opacity(0.3))
                .frame(width: 1000, height: 150)
                .cornerRadius(10)
            Text("An email has been sent to your inbox to confirm your purchase.")
                .font(.custom("Lexend-Regular", size: 24))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
        }.navigationBarBackButtonHidden()
        
        
        NavigationLink {
            HomeView(/*model*/)
        } label: {
            Text("Return to Home Page")
                .disabled(fin)
                .font(Font.custom("Lexend-Regular", size: 24))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .cornerRadius(10)
        }
        .padding()
        .cornerRadius(10)
    }
}

