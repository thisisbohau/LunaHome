//
//  NukiTile.swift
//  Home
//
//  Created by David Bohaumilitzky on 30.06.22.
//

import SwiftUI

struct NukiTile: View {
    var proxy: CGSize
    
    var body: some View {
        
        if false{
            MediumTemplate(proxy: proxy, type: .overlay, device: "")
                .overlay(
                    VStack{
                        Image(systemName: "lock.open.fill")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Text("Unlocked")
                            .padding(.top)
                            .foregroundStyle(.primary)
                    }
                )
                .padding(.bottom, DeviceItemCalculator().spacer)
        }else{
            SmallTemplate(proxy: proxy, type: .overlay, device: "")
                .overlay(
                    HStack{
                        Image(systemName: "lock.fill")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Text("Locked")
                            .foregroundStyle(.secondary)
                            .padding(.leading)
                            .font(.headline)
                        Spacer()
                    }.padding()
                )
                .padding(.bottom, DeviceItemCalculator().spacer)
        }
    }
}

//struct NukiTile_Previews: PreviewProvider {
//    static var previews: some View {
//        NukiTile()
//    }
//}
