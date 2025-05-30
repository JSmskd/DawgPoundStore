//
//  DawgPoundStoreApp.swift
//  DawgPoundStore
//
//  Created by John Sencion on 12/3/24.
//

import SwiftUI
import CloudKit
@main
struct YourApp: App {
    @StateObject var model = ItemViewModel()
    var body: some Scene {
        WindowGroup {
            ap()
                .environmentObject(model)
        }
    }
}
struct ap: View {
    /*(ItemViewModel.self)*/
    @EnvironmentObject var model: ItemViewModel

    var body: some View {
        if !model.loginpromt {
            NavigationStack {
                HomeView()
                    .onAppear {
                        Timer.init(timeInterval: 0.5 , repeats: true) { t in
                            print("hi")
                            DispatchQueue.main.async {
                                if self._model.wrappedValue.timedown <= 0 {
                                    self._model.wrappedValue.update()
                                    self._model.wrappedValue.timedown = 5000
                                }
                            }
                        }.fire()
                    }
            }
        } else {
            Text(model.usr.id)
            account().disabled(model.usr.id != "").onAppear {
                model.database.fetch(withQuery: CKQuery(recordType: "account", predicate: NSPredicate(format: "userCookie == '\(model.usr.id)'"))) { a in
                    do {
                        var b = try a.get().matchResults
                        if b.count == 0 {
                            throw CKError(.unknownItem)
                        }
                        var c = try b.first!.1.get()
                        initDevice(_model, c)

                    } catch {
                        if (error as? CKError)?.code == CKError.unknownItem {
                            DispatchQueue.main.async {
                                model.usr.id = ""
                            }
                        }
                        print(error)
                    }

                }
            }

        }
    }


}
