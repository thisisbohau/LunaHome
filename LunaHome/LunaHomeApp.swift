//
//  LunaHomeApp.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 27.08.22.
//

import SwiftUI

@main
struct LunaHomeApp: App {
    @StateObject var fetcher = Fetcher()
    @StateObject var states = DeviceStates()
    var body: some Scene {
        WindowGroup {
            
            Root()
//                .preferredColorScheme(.light)
                .environmentObject(fetcher)
                .environmentObject(states)
        }
    }
}
