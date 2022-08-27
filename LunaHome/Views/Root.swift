//
//  Root.swift
//  Home 2.0
//
//  Created by David Bohaumilitzky on 24.08.22.
//

import SwiftUI

struct Root: View {
    var body: some View {
        TabView{
            OverviewMain()
                .tabItem {
                    Label("Überblick", image: "homeIcon")
                }
                .tag(1)
            
            Text("Räume")
                .tabItem {
                    Label("Räume", systemImage: "square.on.square")
                }
                .tag(2)
            
            Text("Luna")
                .tabItem {
                    Label("Luna", systemImage: "target")
                }
                .tag(2)
        }
    }
}

struct Root_Previews: PreviewProvider {
    static var previews: some View {
        Root()
    }
}
