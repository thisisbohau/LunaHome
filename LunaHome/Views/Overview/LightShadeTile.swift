//
//  LightShadeTile.swift
//  Home
//
//  Created by David Bohaumilitzky on 30.06.22.
//

import SwiftUI

struct LightShadeTile: View {
    var proxy: CGSize
    
    var body: some View {
        if true{
            MediumTemplate(proxy: proxy, type: .overlay, device: "")
                .overlay(
                    HStack{
                        VStack(alignment: .leading){
                            Spacer()
                            HStack{
                                Text("08")
                                    .font(.title.bold())
                                    .foregroundStyle(.primary)
                                    
                                Circle()
                                    .frame(width: 7, height: 7)
                                    .foregroundColor(.yellow)
                            }
                            Text("Lights on")
                                .font(.caption)
                                .offset(y: -8)
                            Spacer()
                            HStack{
                                Text("08")
                                    .font(.title.bold())
                                    .foregroundStyle(.primary)
                                Circle()
                                    .frame(width: 7, height: 7)
                                    .foregroundColor(.teal)
                            }
                            Text("Shades open")
                                .font(.caption)
                                .offset(y: -8)
                            
                            
                            
                            Spacer()
                        }
                        Spacer()
                    }.foregroundStyle(.secondary)
                        .padding()
                )
                .padding(.bottom, DeviceItemCalculator().spacer)
        }else if true{
            SmallTemplate(proxy: proxy, type: .overlay, device: "")
                .overlay(
                    HStack{
                        VStack(alignment: .leading){
                            Text("08")
                                .font(.title.bold())
                                .foregroundStyle(.primary)
                            Text("Lights on")
                                .font(.caption)
                                .offset(y: -3)
                        }.foregroundStyle(.secondary)
                            .padding()
                        Spacer()
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.yellow)
                            .padding(.trailing, 25)
                    }
                )
                .padding(.bottom, DeviceItemCalculator().spacer)
        }else{
            SmallTemplate(proxy: proxy, type: .overlay, device: "")
                .overlay(
                    HStack{
                        VStack(alignment: .leading){
                            Text("08")
                                .font(.title.bold())
                                .foregroundStyle(.primary)
                            Text("Shades open")
                                .font(.caption)
                                .offset(y: -3)
                        }.foregroundStyle(.secondary)
                            .padding()
                        Spacer()
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.teal)
                            .padding(.trailing, 25)
                    }
                )
                .padding(.bottom, DeviceItemCalculator().spacer)
        }
    }
}
