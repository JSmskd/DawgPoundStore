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
          }
//      }
    }
  }
}
