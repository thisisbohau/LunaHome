//
//  SettingsTile.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 22.10.22.
//

import SwiftUI

struct SettingsTile: View {
    var proxy: CGSize
    @EnvironmentObject var fetcher: Fetcher
    @State var show: Bool = false
    
    
    var body: some View {
        SmallTemplate(proxy: proxy, type: .overlay, device: "")
            .overlay(
                Button(action: {show.toggle()}){
                    HStack{
                        Image(systemName: "gearshape")
                        Text("Einstellungen")
                           
                            .bold()
                    }
                    .foregroundStyle(.primary)
                    .foregroundColor(.primary)
                    .padding(10)
                }
            
            )
            .sheet(isPresented: $show){
                WelcomeView()
            }
    }
}
