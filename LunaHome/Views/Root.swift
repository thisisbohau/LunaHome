//
//  Root.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 24.08.22.
//

import SwiftUI

struct Root: View {
    @EnvironmentObject var fetcher: Fetcher
    @EnvironmentObject var states: DeviceStates
    
    var body: some View {
        TabView{
            OverviewMain()
//                .preferredColorScheme(.dark)
                .tabItem {
                    Label("Überblick", image: "homeIcon")
                }
                .tag(1)
            
            LunaMain()
                .tabItem {
                    Label("Luna", systemImage: "target")
                }
                .tag(2)
            
            RoomView(room: $states.activeRoom)
                .tabItem {
                    Label("Räume", systemImage: "square.on.square")
                }
                .tag(23)
                
            
        }
        .onAppear(perform: {
            fetcher.load()
            fetcher.logTemplate()
            
        })
    }
}

struct Root_Previews: PreviewProvider {
    static var previews: some View {
        Root()
            .preferredColorScheme(.light)
            .environmentObject(Fetcher())
    }
}
