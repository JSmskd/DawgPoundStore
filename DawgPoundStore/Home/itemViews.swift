//
//  itemViews.swift
//  DawgPoundStore
//
//  Created by John Sencion on 5/20/25.
//
import SwiftUI

struct HomeItems: View {
    //    var model:StateObject<ItemViewModel>
    @EnvironmentObject var model: ItemViewModel
    var itms:Binding<[ic]>
    init (_ itms:Binding<[ic]>) {
        //self.model = model
        //        print("{")
        self.itms = itms
        //        for i in model.wrappedValue.homeColecs {
        //            //            print(i.name)
        //            //            for o in i.items {
        //            ////                print(o)
        //            //            }
        //        }
        //        print("}")
    }
    var body: some View {
        // Trending Section
        VStack{
            //            ForEach(0..<model.wrappedValue.homeColecs.count, id:\.self) { noeh in
            //                VStack(alignment: .leading) {
            //                    Text("Trending now")
            //                        .font(.custom("Lexend-Regular", size: 25))
            //                        .foregroundColor(.white)
            //                        .padding(.horizontal)
            //                        .offset(x: 8, y: 15)
            //
            //                    ScrollView(.horizontal, showsIndicators: false) {
            //                        HStack(spacing: 16) {
            //                            ForEach(0..<min(5,(model.wrappedValue.homeColecs)[noeh].items.count), id: \.self) { item in
            //                                itemPreview(model, item: (model.wrappedValue.homeColecs)[noeh].items[item])
            //                                //                                        item.preview
            //                            }
            //                        }
            //                        .padding(.horizontal)
            //                    }
            //                }
            //            }
            ForEach(itms.wrappedValue, id:\.self) { noeh in
                Rectangle()//Spacer
                    .frame(width: 10,height: 23).foregroundStyle(.clear)


                VStack(alignment: .leading) {
                    Text(noeh.name)
                        .font(.custom("Lexend-Regular", size: 25))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    //                        .offset(x: 8, y: 15)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(noeh.items, id: \.self) { item in
                                itemPreview(/*model, */item: item)
                                //                                        item.preview
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
