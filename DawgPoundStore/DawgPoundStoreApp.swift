//
//  DawgPoundStoreApp.swift
//  DawgPoundStore
//
//  Created by John Sencion on 12/3/24.
//

import SwiftUI

@main
struct YourApp: App {
    @StateObject var model = ItemViewModel()
  var body: some Scene {
    WindowGroup {
//      NavigationView {
          NavigationStack{
              HomeView(_model)
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
//                      Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { t in
//                      }
                  }
          }
//      }
    }
  }
}
