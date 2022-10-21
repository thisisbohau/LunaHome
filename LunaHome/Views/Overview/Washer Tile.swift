//
//  Washer Tile.swift
//  LunaHome
//
//  Created by David Bohaumilitzky on 10.10.22.
//

import SwiftUI

struct Washer_Tile: View {
    var proxy: CGSize
    @EnvironmentObject var fetcher: Fetcher
    @State var show: Bool = false
    
    var body: some View {
        SmallTemplate(proxy: proxy, type: .overlay, device: Blind(id: "", name: "", position: 0, closed: false))
            .overlay(
                Button(action: {show.toggle()}){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Waschmaschine")
                                .font(.body)
                                .bold()
                            Text("Aus")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                        Spacer()
                        //                    Image(systemName: "washer")
                        //                        .foregroundColor(.secondary)
                        //                        .font(.headline)
                    }
                    
                    .padding()
                }.foregroundColor(.primary)
            )
            .padding(.bottom, DeviceItemCalculator().spacer)
            .sheet(isPresented: $show){
                WasherControl()
            }
    }
}

//struct Washer_Tile_Previews: PreviewProvider {
//    static var previews: some View {
//        Washer_Tile()
//    }
//}
