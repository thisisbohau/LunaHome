//
//  DoorbellTile.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 13.09.22.
//

import SwiftUI

struct DoorbellTile: View {
    var proxy: CGSize
    @EnvironmentObject var fetcher: Fetcher
    @State var show: Bool = false
    @State var blind: Blind = Blind(id: "", name: "Rollo", position: 0, closed: false)
    
    var body: some View {
        MediumTemplate(proxy: proxy, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
            .overlay(
                Button(action: {show.toggle()}){
                    Text("Rollos")
                }
            )
            .sheet(isPresented: $show){
                BlindControl(blind: $blind)
            }
    }
}

//struct DoorbellTile_Previews: PreviewProvider {
//    static var previews: some View {
//        DoorbellTile()
//    }
//}
