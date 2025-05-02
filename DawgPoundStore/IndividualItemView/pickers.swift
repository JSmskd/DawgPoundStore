//
//  pickers.swift
//  DawgPoundStore
//
//  Created by John Sencion on 4/30/25.
//
import SwiftUI
import CloudKit
struct SizePicker: View {
    var chosenStyle: Int
    var sizes: [blank:[blankSize]]
    var styles: [blank]
    @Binding var chosenSize : Int
    var body: some View {
        if chosenStyle < styles.count {
            Picker("Select Size", selection: $chosenSize) {
                if sizes[styles[chosenStyle]] != nil {
                    let use = sizes[styles[chosenStyle]].unsafelyUnwrapped
                    ForEach(0 ..< use.count, id:\.self) { s in
                        HStack {
                            Text("\(sizes[styles[chosenStyle]]![s].name)")//.tag(ooo)
                                .foregroundStyle(.white)
                        }
                        .tag(s)
                    }
                }
                //                            Text(.description ?? "No sizes available").foregroundStyle(.white)
            }
        }
    }
}
