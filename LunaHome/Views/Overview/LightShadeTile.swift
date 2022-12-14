//
//  LightShadeTile.swift
//  Home
//
//  Created by David Bohaumilitzky on 30.06.22.
//

import SwiftUI

struct LightShadeTile: View {
    @State var show: Bool = false
    @State var light: Light = Light(id: "", state: true, hue: 120, saturation: 255, brightness: 80, type: "", name: "TEST")
    @EnvironmentObject var fetcher: Fetcher
    var proxy: CGSize
    
    func lightsActive() -> (Bool, Int){
        let count = fetcher.data.rooms.flatMap({$0.lights}).filter({$0.state}).count
        
        return (count > 0, count)
        
    }
    
    func blindsActive() -> (Bool, Int){
        let count = fetcher.data.rooms.flatMap({$0.blinds}).filter({!$0.closed}).count
        
        return (count > 0, count)
        
    }
    
    var body: some View {
        VStack{
//        Button(action: {show.toggle()}){
            if lightsActive().0 && blindsActive().0{
                MediumTemplate(proxy: proxy, type: .overlay, device: "")
                    .overlay(
                        HStack{
                            VStack(alignment: .leading){
                                Spacer()
                                HStack{
                                    Text(String(lightsActive().1))
                                        .font(.title.bold())
                                        .foregroundStyle(.primary)
                                    
                                    Circle()
                                        .frame(width: 7, height: 7)
                                        .foregroundColor(.yellow)
                                }
                                Text("Lampen an")
                                    .font(.caption)
                                    .offset(y: -8)
                                Spacer()
                                HStack{
                                    Text(String(blindsActive().1))
                                        .font(.title.bold())
                                        .foregroundStyle(.primary)
                                    Circle()
                                        .frame(width: 7, height: 7)
                                        .foregroundColor(.teal)
                                }
                                Text("Rollos offen")
                                    .font(.caption)
                                    .offset(y: -8)
                                Spacer()
                            }
                            Spacer()
                        }.foregroundStyle(.secondary)
                            .padding()
                    )
                    .padding(.bottom, DeviceItemCalculator().spacer)
            }else if lightsActive().0{
                SmallTemplate(proxy: proxy, type: .overlay, device: "")
                    .overlay(
                        HStack{
                            VStack(alignment: .leading){
                                Text(String(lightsActive().1))
                                    .font(.title.bold())
                                    .foregroundStyle(.primary)
                                Text("Lampen an")
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
                                Text(String(blindsActive().1))
                                    .font(.title.bold())
                                    .foregroundStyle(.primary)
                                Text("Rollos offen")
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
        .sheet(isPresented: $show){
            LightControl(light: $light)
        }
    }
}
