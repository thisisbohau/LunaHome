//
//  NukiTile.swift
//  Home
//
//  Created by David Bohaumilitzky on 30.06.22.
//

import SwiftUI

struct NukiTile: View {
    var proxy: CGSize
    @EnvironmentObject var fetcher: Fetcher
    var body: some View {
        
        if fetcher.data.doorLocks.first(where: {$0.name == "Haustüre"})?.doorOpen ?? false{
            MediumTemplate(proxy: proxy, type: .overlay, device: "")
                .overlay(
                    VStack{
                        Image(systemName: "lock.open.fill")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Text("Entsperrt")
                            .bold()
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
                        Text("Gesperrt")
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


